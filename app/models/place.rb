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
  
  def self.for_location(loc)
    near_places = Place.near [loc.latitude, loc.longitude], SAME_AREA_DIST_KM    
    if near_places.length > 0
      # should get nearest but implement that later
      near_places.first
    else
      place = Place.new
      place.latitude = loc.latitude
      place.longitude = loc.longitude
      place.reverse_geocode
      place.save
      place
    end
  end
end
