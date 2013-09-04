require File.expand_path("../../spec_helper", __FILE__)

describe TripSeparatorRegion do
  #test save / load state
  
  before do
    @user = create(:user)
    @s = TripSeparator.new @user
  end
  
  describe "get_trips" do
    it "should make a trip for each origin-destination pair" do
      @s.should_receive(:visited_stops).and_return ['a', 'b', 'c']
      @s.should_receive(:trip_from_origin_and_dest)
        .ordered.with('a','b').and_return('a-b')
      @s.should_receive(:trip_from_origin_and_dest)
        .ordered.with('b','c').and_return('b-c')     
      @s.should_receive :save_state
      @s.get_trips.should eq ['a-b', 'b-c']
    end
  end
  
  describe "helper functions" do
    it "should select visited stops" do
      @s.should_receive(:visited_areas).and_return ['a', 'b']
      @s.should_receive(:is_stop?).ordered.with('a').and_return true
      @s.should_receive(:is_stop?).ordered.with('b').and_return false
      @s.visited_stops.should eq ['a']
    end
    
    it "should convert visited regions to anchor areas within regions" do
      region = double      
      area = double
      area.should_receive :calc_latitude_longitude
      region.should_receive(:anchor).and_return area
      @s.should_receive(:visited_regions).and_return [region]
      @s.visited_areas.should eq [area]
    end   
  end
  
  describe "visited_regions" do
    it "should handle the no locations case correctly" do
      
    end
    
    it "should handle one new region correctly" do
      
    end
  end
end