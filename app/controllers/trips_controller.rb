class TripsController < ApplicationController
  include GeocodeUtil

  def index
    assign_trips_data
    respond_to do |format|
      format.html
      format.json { render json: {trips: @trips, places: places} }
    end
  end

  def assign_trips_data
    @trips = current_user.trips
      .where('start_place_id <> end_place_id').order('start_time ASC')
    @places = current_user.places.joins(
        'INNER JOIN trips ON trips.start_place_id = places.id
         OR trips.end_place_id = places.id')
      .where('trips.user_id = ? AND trips.start_place_id <> trips.end_place_id',
             current_user.id).distinct
  end

  def waypoints
    # Do this by trip separtor areas
    trip_id = trip_id_param
    trip = Trip.where('id = ? AND user_id = ?', trip_id, current_user.id).take
    if trip
      dist, shape = MapQuestApi.distance_and_shape(
          trip.start_place.latitude.to_s + ',' + trip.start_place.longitude.to_s,
          trip.end_place.latitude.to_s + ',' + trip.end_place.longitude.to_s,
          *map_params)

      waypoints = []
      (0..shape.length-2).step(2) do |i|
        waypoints.push([shape[i], shape[i + 1]])
      end
    end

=begin
    #locs = Location.where('user_id = ? AND recorded_time >= ? AND recorded_time <= ?',
    #  current_user.id, trip.start_time, trip.end_time)
    #  .select(:latitude, :longitude)
    points = TripSeparatorRegion.joins(:anchor_area)
              .where('user_id = ? AND
                      trip_separator_regions.last_time >= ? AND
                      trip_separator_regions.last_time <= ?',
                     current_user.id, trip.start_time, trip.end_time)
              .select(:x, :y, :z)
    waypoints = points.map {|p| as_latitude_longitude p.x, p.y, p.z }
=end

    respond_to do |format|
      format.json { render json: waypoints }
    end
  end

  def trip_id_param
    params.permit(:trip_id)[:trip_id]
  end

  def map_params
    param_syms = [:map_width, :map_height, :map_zoom, :map_lat, :map_lng]
    params.permit(*param_syms).values_at(*param_syms)
  end

  def reimburse
    trips_attrs = []
    prefix = 'reimburse_'
    params.each do |k,v|
      if k.starts_with? prefix
        id = k.slice prefix.length, k.length
        
        trip = Trip.find(id)
        attrs = {
          start_time: trip.start_time,
          start_place_summary: trip.start_place.summary,
          end_place_summary: trip.end_place.summary,
          purpose: trip.purpose,
          miles: trip.distance_in_miles,       
          type: trip.type   
        }                
        trips_attrs.push attrs
      end
    end
    @trip_attrs = trips_attrs 
    gon.trips = @trip_attrs
  end
end