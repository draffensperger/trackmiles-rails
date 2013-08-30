class Location < ActiveRecord::Base
  belongs_to :user
  
  def meters_to(location)
    Geocoder::Calculations.distance_between([self.latitude, self.longitude], 
      [location.latitude,location.longitude], units: :km) * 1000.0
  end
end
