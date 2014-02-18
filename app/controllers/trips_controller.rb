class TripsController < ApplicationController
  def index    
    TripSeparatorWorker.perform_async(current_user.id)
    
    @trips = current_user.trips.where("start_place_id <> end_place_id")
      .order("start_time ASC")
    @trips.each do |t|
      unless t.distance
        t.calc_distance
        t.save
      end
      
      unless t.purpose
        t.purpose = t.default_trip_purpose
        t.save
      end
    end
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