class Place < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude do |place,results|
    if geo = results.first
      place.street = geo.address
      place.city    = geo.city
      place.state = geo.state_code
      place.postal_code = geo.postal_code
      #place.country = geo.country_code
      place.summary = geo.address + ', ' + geo.city + ', ' + geo.state_code      
    end
  end
end
