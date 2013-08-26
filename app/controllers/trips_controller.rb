class TripsController < ApplicationController
  def index
    @locations = current_user.locations.all(:order => 'recorded_time DESC')
    
    next_loc = nil
    @locations.each do |cur_loc|
      #if next_loc and not next_loc.prev_location_id
      if next_loc      
        next_loc.prev_location_id = cur_loc.id
        next_loc.prev_distance = dist_between_locs cur_loc, next_loc
        next_loc.prev_elapsed = next_loc.recorded_time - cur_loc.recorded_time
        if next_loc.prev_elapsed > 0
          next_loc.calced_speed = next_loc.prev_distance / next_loc.prev_elapsed
        end
        #next_loc.save  
      end
      next_loc = cur_loc    
    end
  end
  
  def dist_between_locs(l1, l2)
    Geocoder::Calculations.distance_between([l1.latitude, l1.longitude], 
      [l2.latitude,l2.longitude], units: :km) * 1000.0
  end
end