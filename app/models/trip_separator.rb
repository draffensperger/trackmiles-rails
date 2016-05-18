class TripSeparator
  include GeocodeUtil

  STOP_TIME_THRESHOLD_S = 15 * 60

  attr_accessor :visited_regions, :region, :locs

  def initialize(user)
    @user = user
    @visited_regions = []
  end

  def calc_and_save_trips
    until (locs = unprocessed_locations).empty?
      Rails.logger.debug "Separating trips based on locations #{locs.inspect}"
      locs.each { |l| add_location l }
      @user.save
    end
  end

  def unprocessed_locations
    if @user.current_region
      @user.locations.where('recorded_time > ?', @user.current_region.last_time)
           .order(:recorded_time)
    else
      @user.locations.order(:recorded_time)
    end
  end

  def add_location(loc)
    if @user.current_region
      in_region = @user.current_region.add_loc_if_within_region loc
      if in_region
        create_new_trip if is_stop?(@user.current_region) &&
                           @user.last_stop_region != @user.current_region
      else
        add_location_in_new_region loc
      end
    else
      add_location_in_new_region loc
      @user.last_stop_region = @user.current_region
    end
  end

  def is_stop?(region)
    region.anchor.last_time - region.anchor.first_time > STOP_TIME_THRESHOLD_S
  end

  def add_location_in_new_region(loc)
    @user.current_region.save if @user.current_region
    @user.current_region = TripSeparatorRegion.new_with_center loc
    @user.current_region.user = @user
  end

  def create_new_trip
    create_trip_from_origin_and_dest @user.last_stop_region.anchor,
                                     @user.current_region.anchor
    @user.last_stop_region = @user.current_region
  end

  def create_trip_from_origin_and_dest(origin, dest)
    origin.calc_latitude_longitude
    dest.calc_latitude_longitude
    Trip.create user: @user, from_phone: true,
                start_time: origin.last_time, end_time: dest.first_time,
                start_place: @user.place_for_location(origin),
                end_place: @user.place_for_location(dest),
                distance: TripSeparator.driving_distance(origin, dest)
  end

  def self.driving_distance(from, to)
    MapQuestApi.distance("#{from.latitude},#{from.longitude}",
                         "#{to.latitude},#{to.longitude}")
  end
end
