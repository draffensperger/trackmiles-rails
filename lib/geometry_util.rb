module GeometryUtil
  include Math
  
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
end