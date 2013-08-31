class Location < ActiveRecord::Base
  include Math
  include Geocoder::Calculations
  
  belongs_to :user
  
  alias_attribute :x, :n_vector_x
  alias_attribute :y, :n_vector_y
  alias_attribute :z, :n_vector_z
  
  def as_radians(degrees)
    degrees / 180.0 * PI
  end
  def as_degrees(radians)
    radians / PI * 180.0
  end
  
  # See http://en.wikipedia.org/wiki/N-vector
  def calc_n_vector
    lat = as_radians self.latitude
    lon = as_radians self.longitude
    cos_lat = cos(lat)
    self.n_vector_x = cos_lat * cos(lon) 
    self.n_vector_y = cos_lat * sin(lon)
    self.n_vector_z = sin(lat)
  end
  
  def calc_latitude_longitude
    x = self.n_vector_x
    y = self.n_vector_y
    z = self.n_vector_z
    self.latitude = as_degrees atan2(z, sqrt(x*x + y*y))
    self.longitude = as_degrees atan2(y, x)
  end
  
  def km_to(loc)
    distance_between [self.latitude,self.longitude],[loc.latitude,loc.longitude]
  end
  
  def meters_to(loc)
    km_to(loc) * 1000.0
  end
end
