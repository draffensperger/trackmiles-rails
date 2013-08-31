
def dist_sq(p1, p2)
  dx = p1.x - p2.x
  dy = p1.y - p2.y
  dz = p1.z - p2.z
  dx*dx + dy*dy + dz*dz
end

def dist_km(l1, l2)
  Geocoder::Calculations::distance_between [l1.latitude,l2.longitude],
    [l1.latitude,l2.longitude]
end

class TripSeparator
  include Math
  
  R_EARTH_M = 6371000.0
  SAME_AREA_DIST_M = 160.0  
  SAME_AREA_DIST_KM = SAME_AREA_DIST_M / 1000.0 
  SAME_AREA_DIST_UNIT = SAME_AREA_DIST_M / R_EARTH_M
  SAME_AREA_DIST_UNIT_SQ = SAME_AREA_DIST_UNIT * SAME_AREA_DIST_UNIT
  ERROR_RANGE_DIST_M = 800.0
  ERROR_RANGE_DIST_UNIT = ERROR_RANGE_DIST_M / R_EARTH_M
  ERROR_RANGE_DIST_UNIT_SQ = ERROR_RANGE_DIST_UNIT * ERROR_RANGE_DIST_UNIT 
  
  TIME_THRESHOLD_S = 15 * 60 
  
  def initialize(locations)    
    @locs = locations
    @locs.each(&:calc_n_vector)
    @user = @locs[0].user if @locs.length > 0
    @anchor_areas = []
  end
  
  def get_trips        
    calc_destinations
    trips = []
    origin = @destinations[0] if @destinations.length > 0
    for i in 1..@destinations.length-1
      dest = @destinations[i]    
      
      trip = Trip.new
      trip.user = @user
      trip.start_time = origin.last_time
      trip.end_time = dest.first_time      
      trip.start_place = place_for_location origin
      trip.end_place = place_for_location dest
      trip.distance = dist_km origin, dest
      trip.from_phone = true             
      trips.push trip
      
      origin = dest
    end    
    trips
  end
  
  def place_for_location(loc)
    near_places = Place.near [loc.latitude, loc.longitude], SAME_AREA_DIST_KM    
    if near_places.length > 0
      # should get nearest but implement that later
      near_places.first
    else
      place = Place.new
      place.latitude = loc.latitude
      place.longitude = loc.longitude
      place.reverse_geocode
      place.save
      place
    end
  end
  
  def calc_destinations
    calc_anchor_areas
    @destinations = @anchor_areas
      .select {|a| a.last_time - a.first_time > TIME_THRESHOLD_S}     
  end
  
  def calc_anchor_areas    
    region = Region.new @locs[0] if @locs.length > 0
    
    for i in 1..@locs.length-1
      loc = @locs[i]
      
      in_region = region.add_loc_if_within_region loc
      if not in_region
        @anchor_areas.push region.anchor
        region = Region.new loc
      end      
    end    

    @anchor_areas.push region.anchor if region    
    @anchor_areas.each {|a| a.center.calc_latitude_longitude}    
  end
  
  class Region
    attr_accessor :areas, :anchor
    
    def initialize(loc)      
      @anchor = Area.new loc
      @areas = [@anchor] 
    end
    
    def add_loc_if_within_region(loc)
      anchor_dist_sq = dist_sq loc, @anchor
      if anchor_dist_sq > ERROR_RANGE_DIST_UNIT_SQ
        return false
      end
            
      if anchor_dist_sq < SAME_AREA_DIST_UNIT_SQ
        @anchor.add_location loc
      else
        closest, dist = closest_area_and_dist_sq loc      
        if dist < SAME_AREA_DIST_UNIT_SQ
          closest.add_location loc
          @anchor = closest if closest.locs.length > @anchor.locs.length            
        else
          areas.push Area.new loc
        end
      end      
      true
    end
    
    def closest_area_and_dist_sq(loc)
      closest = nil
      closest_dist = Float::MAX
      @areas.each do |area|          
        dist = dist_sq area, loc
        if dist < closest_dist
          closest = area
          closest_dist = dist
        end
      end
      [closest, closest_dist]
    end
  end
  
  class Area
    attr_accessor :center, :locs, :first_time, :last_time,
      :center_total_x, :center_total_y, :center_total_z,
      :latitude, :longitude 
    
    def initialize(loc)
      @locs = [loc]
      @center = loc.clone      
      @first_time = loc.recorded_time
      @last_time = loc.recorded_time
      @center_total_x = loc.x
      @center_total_y = loc.y
      @center_total_z = loc.z
    end    
    
    def add_location(loc)
      @last_time = loc.recorded_time      
      @locs.push loc
      calc_new_center loc      
    end
    
    def calc_new_center(loc)
      @center_total_x += loc.x
      @center_total_y += loc.y
      @center_total_z += loc.z
      num_locs = @locs.length.to_f
      @center.x = @center_total_x / num_locs 
      @center.y = @center_total_y / num_locs
      @center.z = @center_total_z / num_locs  
    end
    
    def x() @center.x end
    def y() @center.y end
    def z() @center.z end
    def latitude() @center.latitude end
    def longitude() @center.longitude end  
  end
end