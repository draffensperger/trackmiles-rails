class TripsController < ApplicationController
  def index

                
    @trips = TripSeparator.new(@locations).get_trips    
  end
end