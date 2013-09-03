require File.expand_path("../../spec_helper", __FILE__)

class MockPoint
  attr_accessor :x, :y, :z
  def initialize(x, y, z)
    self.x = x
    self.y = y
    self.z = z
  end
end

describe GeometryUtil do
  before do    
    DELTA = 0.00000000001
  end  
  
  it "should calculate distance squared" do
    GeometryUtil.dist_sq(MockPoint.new(1.0, 2.0, 3.0), 
      MockPoint.new(3.0, 4.0, 5.0)).should be_within(DELTA).of(12.0)
  end
  
  it "should convert radians and degrees" do
    GeometryUtil.as_degrees(-Math::PI).should be_within(DELTA).of(-180.0)
    GeometryUtil.as_radians(90).should be_within(DELTA).of(Math::PI/2.0)
  end
  
  it "should find closest point and distance squared" do
    query_point = MockPoint.new(1.0, 2.0, 3.0)
    points = [MockPoint.new(3.0, 4.0, 5.0), MockPoint.new(30.0, 40.0, 50.0)]
    closest, dist_2 = GeometryUtil.find_closest_and_dist_sq(query_point, points)
    closest.should eq points[0]
    dist_2.should be_within(DELTA).of(12.0)
  end
end