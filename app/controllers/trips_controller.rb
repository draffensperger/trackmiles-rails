class TripsController < ApplicationController
  def index
    TripSeparator.new(current_user).calc_and_save_trips
    @trips = current_user.trips    
  end
end