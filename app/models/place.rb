class Place < ActiveRecord::Base
  belongs_to :user

  reverse_geocoded_by :latitude, :longitude do |place,results|
    if geo = results.first
      place.street = Place.address_only geo.address, geo.city
      place.city    = geo.city
      place.state = geo.state_code
      place.postal_code = geo.postal_code
      #place.country = geo.country_code
      #place.summary = place.street + ', ' + place.city + ', ' + place.state
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
end
