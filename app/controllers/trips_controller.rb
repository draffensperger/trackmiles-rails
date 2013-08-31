class TripsController < ApplicationController
  def index
    @locations = current_user.locations
      .where('recorded_time > ?', Date.new(2013, 8, 23))
      .all(:order => 'recorded_time')
                
    @trips = TripSeparator.new(@locations).get_trips    
  end
end