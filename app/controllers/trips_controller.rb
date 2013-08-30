require 'set'

def same_area_dist
  160
end

def error_range_dist
  800
end
  
def loc_point(loc)
  [loc.latitude, loc.longitude]
end  

def dist_between_points(p1, p2)    
  Geocoder::Calculations.distance_between(p1, p2, units: :km) * 1000.0
end
  
def dist_between_locs(l1, l2)
  dist_between_points loc_point(l1), loc_point(l2)
end

class TripsController < ApplicationController
  def index
    @locations = current_user.locations
      .where('recorded_time > ?', Date.new(2013, 8, 23))
      .all(:order => 'recorded_time')
    
    for i in 0..@locations.length-1
      loc = @locations[i]
      
      for prev_i in 1..3
        next if i - prev_i < 0          
        prev = @locations[i - prev_i]
        
        unless loc["prev#{prev_i.to_s}_location_id".to_sym]                
          dist = loc.meters_to prev
          elapsed = loc.recorded_time - prev.recorded_time 
          if elapsed > 0 
            speed = dist / elapsed
          end
          
          loc["prev#{prev_i.to_s}_location_id".to_sym] = prev.id
          loc["prev#{prev_i.to_s}_distance".to_sym] = dist          
          loc["prev#{prev_i.to_s}_elapsed".to_sym] = elapsed
          loc["prev#{prev_i.to_s}_speed".to_sym] = speed
        end              
      end
      
      loc.save if loc.changed?        
    end    
    
    areas = []
    current_area = nil
    anchors = []
    regions = []
    
    for i in 0..@locations.length-1
      loc = @locations[i]
      
      if areas.empty?
        area = Area.new
        area.add_location loc
        current_area = area
        areas.push area
      else
        closest_area, closest_dist = closest_area_and_dist areas, loc
        
        if closest_dist < same_area_dist
          if closest_area == current_area
            closest_area.add_location loc
          else
            closest_area.add_reentry loc, @locations, i 
            current_area = closest_area
          end
        elsif closest_dist < error_range_dist
          area = Area.new
          area.add_location loc
          current_area = area
          areas.push area  
        end
       
        anchor_area = calc_anchor_area areas
        anchor_dist = dist_between_points loc_point(loc), anchor_area.center
        if anchor_dist > error_range_dist
          # Then we have traveled from the area, and need to backfill as way points
          # collapse the areas into a point.
          # create a new area
          
          # need to back fill the regions.
          regions.push anchor_area
          
          area = Area.new
          area.add_location loc
          current_area = area
          areas = [area]  
        end
      end      
    end
    
    @regions = regions
  end
  
  def calc_anchor_area(areas)
    sorted = areas.sort do |a1,a2| 
      if a1.reentries.length > a2.reentries.length
        -1
      elsif a1.reentries.length < a2.reentries.length
        1
      elsif a1.first_time < a2.first_time
        -1
      elsif a1.first_time > a2.first_time
        1
      else
        0
      end
    end
    sorted.first
  end  
  
  def is_error_point(locs, i)
    loc = locs[i]
      
    points_error = 0
    points_not_error 0
    
    i_fwd = 0
    i_backward = 0
    around_count = 0
    
    while around_count < 16
      
      i_fwd = i_fwd + 1
    end
  end
  
  def closest_area_and_dist(areas, loc)
    closest = nil
    closest_dist = nil
    areas.each do |area|
      dist = dist_between_points area.center, loc_point(loc)
      if closest_dist.nil? or dist < closest_dist
        closest = area
        closest_dist = dist
      end
    end
    [closest, closest_dist]
  end 
  
  class AreaReentry
    attr_accessor :cos_angle, :dist_inside, :dist_outside
    
    def initialize(dist_inside, dist_outside)
      # We make the simplifying assumption of treating the outside travel
      # as an isocelese triangle and calculate the angle cosine with the law
      # of cosines
      @dist_inside = dist_inside
      @dist_outside = dist_outside
      @cos_angle = 1 - dist_inside * dist_inside /
        (2 * dist_outside * dist_outside) unless dist_outside == 0
    end
    
  end
  
  class Area
    attr_accessor :center, :locs, :radius, :reentries, :locs_set, :last_time,
      :first_time
    
    def initialize
      @reentries = []
      @locs = []
      @locs_set = Set.new
    end
    
    def add_reentry(loc, locations, index)
      dist_outside = 0
      dist_inside = 0
      
      begin
        index = index - 1
        past_loc = locations[index]
        
        dist_outside += dist_between_locs past_loc, locations[index + 1]
        
        if locs_set.include? past_loc          
          dist_inside = dist_between_locs past_loc, loc          
          break
        end
      end while index > 0
      @reentries.push AreaReentry.new dist_inside, dist_outside
      
      add_location loc
    end
    
    def add_location(loc)
      @first_time = loc.recorded_time if locs.empty?
      @last_time = loc.recorded_time
      @locs.push loc
      
      @locs_set.add loc
      if @center
        @center = calc_center loc_point loc
        @radius = calc_radius
      else
        @center = loc_point loc
        @radius = 0
      end      
    end
    
    def calc_radius
      @locs.map{|l| dist_between_points center, loc_point(l)}.max      
    end     
    
    def calc_center(new_point)
      num_locs = locs.length
      [(center[0] * (num_locs - 1) + new_point[0]) / num_locs,
       (center[1] * (num_locs - 1) + new_point[1]) / num_locs]
    end    
  end
end