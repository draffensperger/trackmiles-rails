module GeometryUtil
  include Math  
  extend self
  
  def dist_sq(p1, p2)
    dx = p1.x - p2.x
    dy = p1.y - p2.y
    dz = p1.z - p2.z
    dx*dx + dy*dy + dz*dz
  end

  def as_radians(degrees)
    degrees / 180.0 * PI
  end
  
  def as_degrees(radians)
    radians / PI * 180.0
  end
  
  def find_closest_and_dist_sq(query_point, points)
    closest = nil
    closest_dist = Float::MAX
    points.each do |cur_point|
      dist = dist_sq query_point, cur_point
      if dist < closest_dist
        closest = cur_point
        closest_dist = dist
      end
    end
    [closest, closest_dist]
  end

  def degrees_sq_dist(l1, l2)
    d_lat = l1.latitude - l2.latitude
    d_long = l1.longitude - l2.longitude
    d_lat * d_lat + d_long * d_long
  end

  def closest_by_degrees_sq(query_loc, locations)
    locations.min_by { |l| degrees_sq_dist(l, query_loc) }
  end
end