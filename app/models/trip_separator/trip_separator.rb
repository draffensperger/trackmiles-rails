require 'activerecord-import'

class TripSeparator
  include Math
  include GeocodeUtil
  
  SAME_AREA_DIST_M = 160.0  
  SAME_AREA_DIST_KM = SAME_AREA_DIST_M / 1000.0 
  SAME_AREA_DIST_UNIT = SAME_AREA_DIST_M / R_EARTH_M
  SAME_AREA_DIST_UNIT_SQ = SAME_AREA_DIST_UNIT * SAME_AREA_DIST_UNIT
  ERROR_RANGE_DIST_M = 800.0
  ERROR_RANGE_DIST_UNIT = ERROR_RANGE_DIST_M / R_EARTH_M
  ERROR_RANGE_DIST_UNIT_SQ = ERROR_RANGE_DIST_UNIT * ERROR_RANGE_DIST_UNIT 
  
  TIME_THRESHOLD_S = 15 * 60 
  
  def initialize(user)
    @user = user
    @locs = locations
    @last_region = user.trip_separator_region
    
    if @last_region
      @locs = user.locations
        .where('recorded_time > ?', @last_region.last_time)
        .all(:order => 'recorded_time')
    else
      @locs = user.locations.all(:order => 'recorded_time')
    end
    @locs.each(&:calc_n_vector)    
    
    @anchor_areas = []
  end
  
  def get_trips
    dests = self.calc_destinations    
    trips = []
    origin = dests[0] if dests.length > 0
    for i in 1..dests.length-1
      dest = dests[i]    
      
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
  
  def calc_destinations
    @destinations = calc_anchor_areas
      .select {|a| a.last_time - a.first_time > TIME_THRESHOLD_S}     
  end
  
  def calc_anchor_areas
    if @last_region
      region = @last_region
    else
      region = Region.new @locs[0] if @locs.length > 0
    end    
    
    for i in 1..@locs.length-1
      loc = @locs[i]
      
      in_region = region.add_loc_if_within_region loc
      if not in_region
        @anchor_areas.push region.anchor
        region = Region.new loc
      end      
    end   

    @anchor_areas.push region.anchor if region    
    @anchor_areas.each do |a|
      a.center.calc_latitude_longitude
      a.region = region
      a.save
    end    
    
    @last_region.delete if @last_region
    @last_region = region
    @last_region.save
    Area.import @anchor_areas
    
    @anchor_areas
  end
end