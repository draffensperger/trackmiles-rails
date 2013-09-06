class Place < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude do |place,results|
    if geo = results.first
      place.street = Place.address_only geo.address, geo.city
      place.city    = geo.city
      place.state = geo.state_code
      place.postal_code = geo.postal_code
      #place.country = geo.country_code
      place.summary = geo.address + ', ' + geo.city + ', ' + geo.state_code      
    end
  end
  
  def self.address_only(address, city)
    city_start = address.rindex city
    if city_start
      address.slice! city_start, address.length - 1
    end
    address.rstrip!
    address.slice!(address.length - 1) if address[-1] == ','    
    address
  end
  
  SAME_PLACE_DIST_KM = 160.0 / 1000.0
  def self.for_location(loc)
    near_places = Place.near [loc.latitude, loc.longitude], SAME_PLACE_DIST_KM    
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
