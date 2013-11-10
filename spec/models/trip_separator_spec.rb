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
      @s.get_trips.should eq ['a-b', 'b-c']
    end
    
    it "should get no trips for a single region" do
      @s.should_receive(:visited_stops).and_return ['a']
      @s.should_not_receive :trip_from_origin_and_dest
      @s.get_trips.should eq []
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
      @s.should_receive(:locations_for_user).and_return []
      @s.visited_regions.should eq []
    end    
    
    def expect_add_loc(region, loc, within_region)
      region.should_receive(:add_loc_if_within_region)
        .ordered.with(loc).and_return within_region
    end
    
    def expect_new_region(region, loc)
      TripSeparatorRegion.should_receive(:new_with_center).with(loc)
        .and_return(region)
    end
    
    it "should handle a series of locations and return correct regions" do
      locs = 4.times.map {|i| 'loc'+i.to_s}
      regions = 2.times.map {|i| build_stubbed(:trip_separator_region)}
      
      @s.should_receive(:locations_for_user).and_return locs
      
      expect_new_region regions[0], locs[0]
      expect_add_loc regions[0], locs[0], true
      expect_add_loc regions[0], locs[1], true      
      expect_add_loc regions[0], locs[2], false
      
      expect_new_region regions[1], locs[2]
      expect_add_loc regions[1], locs[3], true
      
      @s.visited_regions.should match_array regions
    end
  end
end