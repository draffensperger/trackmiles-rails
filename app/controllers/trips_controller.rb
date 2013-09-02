class TripsController < ApplicationController
  def index                
    @trips = TripSeparator.new(current_user).get_trips    
  end
end