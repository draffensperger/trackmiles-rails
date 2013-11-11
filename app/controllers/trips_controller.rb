class TripsController < ApplicationController
  def index
    TripSeparator.new(current_user).calc_and_save_trips
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
        trips_attrs.push Trip.find(id).attributes
      end
    end
    @trips_json = trips_attrs.to_json
  end
end