require File.expand_path('../../spec_helper', __FILE__)

class MockPoint
  attr_accessor :x, :y, :z
  def initialize(x, y, z)
    self.x = x
    self.y = y
    self.z = z
  end
end

describe GeometryUtil do
  delta = 0.00000000001
  
  it 'should calculate distance squared' do
    GeometryUtil.dist_sq(MockPoint.new(1.0, 2.0, 3.0), 
      MockPoint.new(3.0, 4.0, 5.0)).should be_within(delta).of(12.0)
  end
  
  it 'should convert radians and degrees' do
    GeometryUtil.as_degrees(-Math::PI).should be_within(delta).of(-180.0)
    GeometryUtil.as_radians(90).should be_within(delta).of(Math::PI/2.0)
  end
  
  it 'should find closest point and distance squared' do
    query_point = MockPoint.new(1.0, 2.0, 3.0)
    points = [MockPoint.new(3.0, 4.0, 5.0), MockPoint.new(30.0, 40.0, 50.0)]
    closest, dist_2 = GeometryUtil.find_closest_and_dist_sq(query_point, points)
    closest.should eq points[0]
    dist_2.should be_within(delta).of(12.0)
  end

  it 'should find degrees squared between items' do
    l1 = double
    l1.stub latitude: 26.0, longitude: -82.0

    l2 = double
    l2.stub latitude: 24.0, longitude: -79.0

    GeometryUtil.degrees_sq_dist(l1, l2).should be_within(delta).of(13.0)
  end

  it 'should find closest point by degrees squared' do
    l1 = double
    l1.stub latitude: 26.0, longitude: -82.0

    l2 = double
    l2.stub latitude: 24.0, longitude: -79.0

    l = double
    l.stub latitude: 24.2, longitude: -80.0

    GeometryUtil.closest_by_degrees_sq(l, [l1, l2]).should eq l2
  end
end