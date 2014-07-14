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