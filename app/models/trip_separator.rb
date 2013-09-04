class TripSeparator
  include GeocodeUtil
 
  STOP_TIME_THRESHOLD_S = 15 * 60 
  
  attr_accessor :visited_regions, :region, :locs
  
  def initialize(user)
    @user = user    
    @visited_regions = []
    load_state
  end
  
  def save_state 
    @user.trip_separator_region = @region 
    @user.save
  end
  
  def load_state
    @region = @user.trip_separator_region
    if @region
      @locs = @user.locations.where('recorded_time > ?', region.last_time)
        .all(:order => 'recorded_time')
    else
      @locs = @user.locations.all(:order => 'recorded_time')
    end                 
  end
  
  def get_trips
    stops = visited_stops    
    trips = []
    for i in 0..stops.length-2
      trips.push trip_from_origin_and_dest stops[i], stops[i+1]
    end
    save_state
    trips
  end
  
  def trip_from_origin_and_dest(origin, dest)
    Trip.new user: @user, distance: dist_km(origin, dest), from_phone: true,
      start_time: origin.last_time, end_time: dest.first_time,
      start_place: Place.for_location(origin), 
      end_place: Place.for_location(dest)
  end
  
  def is_stop?(area)
    a.last_time - a.first_time > STOP_TIME_THRESHOLD_S
  end
  
  def visited_stops
    visited_areas.select {|a| is_stop? a}
  end
  
  def visited_areas
    visited_regions.map {|r|
      anchor = r.anchor
      anchor.calc_latitude_longitude
      anchor
    }
  end
  
  def visited_regions
    @locs.each {|l| add_location l}
    @visited_regions.push @region if @region
    @visited_regions
  end  
  
  def add_location(loc)
    @region ||= TripSeparatorRegion.new_with_center loc
    in_region = @region.add_loc_if_within_region loc
    add_location_in_new_region(loc) if not in_region
  end
  
  def add_location_in_new_region(loc)
    @visited_regions.push @region
    @region = TripSeparatorRegion.new_with_center loc
  end  
end