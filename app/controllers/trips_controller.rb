require 'set'

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
    
    for i in 0..@locations.length-1
      loc = @locations[i]
      
      if areas.empty?
        area = Area.new
        area.add_location loc
        current_area = area
        areas.push area
      else
        closest_area, closest_dist = closest_area_and_dist areas, loc
        
        if closest_dist < error_range_dist
          if closest_area == current_area
            closest_area.add_location loc
          else
            closest_area.add_reentry loc, @locations, i 
            current_area = closest_area
          end
        elsif farthest_dist > error_range_dist
          # Then we have traveled from the area, and need to backfill as way points
          # collapse the areas into a point.
        else
          # create a new area          
        end
      end      
    end
  end
  
  def most_likely_area(areas)
    sorted = areas.sort do |a1,a2| 
      if a1.reentries.length < a2.reentries.length
        -1
      elsif a1.reentries.length > a2.reentries.length
        1
      elsif a1.last_time < a2.last_time
        -1
      elsif a1.last_time > a2.last_time
        1
      else
        0
      end
    end
    sorted.first
  end
  
  def same_area_dist
    160
  end
  
  def error_range_dist
    800
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
    areas.reduce([nil, FIXNUM_MAX]) do |closest, area|
      dist = dist_between_points area.center, loc_point(loc)
      if dist < closest[1]
        closest = [loc, dist]
      end
    end
  end
  
  def dist_between_points(p1, p2)    
    Geocoder::Calculations.distance_between(p1, p2, units: :km) * 1000.0
  end
    
  def dist_between_locs(l1, l2)
    dist_between_points loc_point(l1), loc_point(l2)
  end
  
  class AreaReentry
    attr_accessor :cos_angle, :dist_inside, :dist_outside
    
    def initialize(dist_inside, dist_outside)
      # We make the simplifying assumption of treating the outside travel
      # as an isocelese triangle and calculate the angle cosine with the law
      # of cosines
      self.dist_inside = dist_inside
      self.dist_outside = dist_outside
      cos_angle = 1 - dist_inside * dist_inside /
        (2 * dist_outside * dist_outside) unless dist_outside == 0
    end
    
  end
  
  class Area
    attr_accessor :center, :locs, :radius, :rentries, :locs_set, :last_time
    
    def initialize
      rentries = []
      locs = []
      locs_set = Set.new
    end
    
    def add_reentry(loc, locations, index)
      dist_outside = 0
      dist_inside = 0
      
      begin
        index = index - 1
        past_loc = locations[index]
        
        dist_outside += dist_between_locs past_loc locations[index + 1]
        
        if locs_set.include? past_loc          
          dist_inside = dist_between_locs past_loc loc          
          break
        end
      end while index > 0
      rentries.push AreaReentry.new dist_inside, dist_outside
      
      add_location loc
    end
    
    def add_location(loc)    
      locs.push loc
      locs_set.add loc
      if center
        center = calc_center loc_point loc
        radius = calc_radius
      else
        center = loc_point loc
        radius = 0
      end
      last_time = loc.recorded_time
    end
    
    def calc_radius
      locs.map{|l| dist_between_points center, loc_point(l)}.max      
    end
    
    def loc_point(loc)
      [loc.latitude, loc.longitude]
    end    
    
    def calc_center(new_point)
      num_locs = locs.length
      [(center[0] * (num_locs - 1) + new_point[0]) / num_locs,
       (center[1] * (num_locs - 1) + new_point[1]) / num_locs]
    end
    
    def dist_between_points(p1, p2)    
      Geocoder::Calculations.distance_between(p1, p2, units: :km) * 1000.0
    end
      
    def dist_between_locs(l1, l2)
      dist_between_points loc_point(l1), loc_point(l2)
    end
  end
end