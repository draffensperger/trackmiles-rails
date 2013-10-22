require File.expand_path("../../spec_helper", __FILE__)

class MockLocation
  include GeocodeUtil
  attr_accessor :x, :y, :z, :latitude, :longitude  
end

describe GeocodeUtil do    
  delta = 0.00000001
  
  before do           
    @l = MockLocation.new
    @l.latitude = 42.358056; @l.longitude = -71.063611
    @l.x = 0.23980233984; @l.y = -0.69895645579; @l.z = 0.67376161266    
  end    
  
  it "should should convert between n-vector to latitude, longitude" do    
    x, y, z = @l.as_n_vector @l.latitude, @l.longitude
    x.should be_within(delta).of @l.x
    y.should be_within(delta).of @l.y
    z.should be_within(delta).of @l.z
    
    lat, lon = @l.as_latitude_longitude @l.x, @l.y, @l.z
    lat.should be_within(delta).of @l.latitude
    lon.should be_within(delta).of @l.longitude
  end
    
  it "should set coordinates for n-vector or latitude, longitude" do
    l2 = MockLocation.new
    l2.latitude = @l.latitude
    l2.longitude = @l.longitude
    l2.calc_n_vector
    l2.x.should be_within(delta).of @l.x
    l2.y.should be_within(delta).of @l.y
    l2.z.should be_within(delta).of @l.z
    
    l3 = MockLocation.new
    l3.x = @l.x; l3.y = @l.y; l3.z = @l.z
    l3.calc_latitude_longitude
    l3.latitude.should be_within(delta).of @l.latitude
    l3.longitude.should be_within(delta).of @l.longitude
  end
end