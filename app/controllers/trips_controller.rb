class TripsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: trips_data }
    end
  end

  def trips_data
    trips = current_user.trips
      .where('start_place_id <> end_place_id').order('start_time ASC')
    places = current_user.places.joins(
        'INNER JOIN trips ON trips.start_place_id = places.id
         OR trips.end_place_id = places.id')
      .where('trips.user_id = ? AND trips.start_place_id <> trips.end_place_id',
             current_user.id).distinct
    {trips: trips, places: places}
  end

  def waypoints
    # Do this by trip separtor areas
    trip_id = trip_id_param
    trip = Trip.where('id = ? AND user_id = ?', trip_id, current_user.id).take
    locs = Location.where('user_id = ? AND recorded_time >= ? AND recorded_time <= ?',
      current_user.id, trip.start_time, trip.end_time)
      .select(:latitude, :longitude)
    waypoints = locs.map {|l| [l.latitude, l.longitude]}

    respond_to do |format|
      format.json { render json: waypoints }
    end
  end

  def trip_id_param
    params.permit(:trip_id)[:trip_id]
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