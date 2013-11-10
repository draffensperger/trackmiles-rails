module GeocodeUtil
  include Geocoder::Calculations
  include GeometryUtil
    
  R_EARTH_KM = 6371.0
  R_EARTH_M = R_EARTH_KM * 1000.0
    
  # See http://en.wikipedia.org/wiki/N-vector
  
  def as_n_vector(latitude, longitude)
    lat = as_radians latitude
    lon = as_radians longitude
    cos_lat = cos(lat)
    [cos_lat*cos(lon), cos_lat*sin(lon), sin(lat)]
  end
  
  def as_latitude_longitude(x, y, z)
    [as_degrees(atan2(z, sqrt(x*x + y*y))), as_degrees(atan2(y, x))]
  end
  
  def dist_m(l1, l2)
    Geocoder::Calculations::distance_between([l1.latitude,l1.longitude],
      [l2.latitude,l2.longitude]) * 1000.0
  end
  
  def calc_latitude_longitude
    self.latitude, self.longitude = as_latitude_longitude self.x, self.y, self.z
  end
  
  def calc_n_vector
    self.x, self.y, self.z = as_n_vector self.latitude, self.longitude      
  end
end