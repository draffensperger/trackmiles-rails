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
    end
  end
end