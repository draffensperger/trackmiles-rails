require File.expand_path("../../spec_helper", __FILE__)

describe TripSeparatorRegion do
  delta = 0.000000001
  
  before do
    @anchor_loc = build(:loc_no_user1)
    @anchor_loc.calc_n_vector  
    
    @loc = build(:loc_no_user1)
    @loc.calc_n_vector
    @loc.x += 2.0
    @loc.y += 2.0
    @loc.z += 2.0
    
    @r = TripSeparatorRegion.new_with_center @anchor_loc    
  end
  
  describe "anchor_dist" do
    it "should calculate distance squared to anchor" do    
      @r.loc_to_add = @loc
      @r.calc_anchor_dist
      @r.anchor_dist.should be_within(delta).of(12.0)            
    end
    
    it "should recalculate distance squared to anchor for new locations" do
      @r.loc_to_add = @loc
      @r.calc_anchor_dist
      @r.anchor_dist.should be_within(delta).of(12.0)  
      
      @loc.x += 1.0
      @r.calc_anchor_dist
      @r.anchor_dist.should be_within(delta).of(17.0)
    end
  end  
  
  describe "add_loc_if_within_region" do
    before do
      @r.should_receive(:calc_anchor_dist)
      @r.should_receive(:anchor_dist).and_return 2.0
    end
    
    after do
      @r.loc_to_add.should eq @loc
    end
    
    it "should return false if location not in region" do
      @r.should_receive(:within_region_threshold?).with(2.0).and_return false
      @r.add_loc_if_within_region(@loc).should eq false      
    end
    
    it "should return true and add location if location is in region" do      
      @r.should_receive(:within_region_threshold?).with(2.0).and_return true
      @r.should_receive(:add_loc_to_region)
      @r.add_loc_if_within_region(@loc).should eq true
    end
  end
  
  describe "add_loc_to_region" do
    before do
      @r.loc_to_add = @loc
      @r.should_receive(:anchor_dist).and_return 2.0
    end    
    
    it "should add to the anchor if within the anchor's area threshold" do      
      @r.should_receive(:within_area_threshold?).with(2.0).and_return true
      @r.should_not_receive :add_loc_to_closest_or_new_area
      @r.anchor.should_receive(:add_location).with @loc
      @r.add_loc_to_region
    end
    
    it "should add to closest location or a new one otherwise" do
      @r.should_receive(:within_area_threshold?).with(2.0).and_return false 
      @r.should_receive :add_loc_to_closest_or_new_area
      @r.anchor.should_not_receive :add_location
      @r.add_loc_to_region
    end      
  end
  
  describe "add_loc_to_closest_or_new_area" do
    before do
      @r.loc_to_add = @loc
      @r.should_receive(:areas).and_return ['a','b'] 
      @r.should_receive(:find_closest_and_dist_sq).with(@loc, ['a','b'])
        .and_return ['a', 2.0]  
    end
    
    it "should add to closest if within area threshold" do      
      @r.should_receive(:within_area_threshold?).with(2.0).and_return true
      @r.should_receive(:add_loc_to_existing_area).with('a')
      @r.should_not_receive :add_loc_as_new_area
      @r.add_loc_to_closest_or_new_area
    end
    
    it "should add to new area if closest not within threshold" do
      @r.should_receive(:within_area_threshold?).with(2.0).and_return false
      @r.should_receive :add_loc_as_new_area
      @r.should_not_receive :add_loc_to_existing_area
      @r.add_loc_to_closest_or_new_area
    end
  end
  
  describe "add_loc_to_existing_area" do
    before do
      @r.loc_to_add = @loc
      
      @anchor = build(:trip_separator_area)
      @r.anchor = @anchor
      
      @area = build(:trip_separator_area)      
      @area.should_receive(:add_location).with @loc      
    end
    
    it "should change anchor if other area has more locations" do      
      @r.anchor.should_receive(:num_locations).and_return(1)
      @area.should_receive(:num_locations).and_return(2)
      @r.add_loc_to_existing_area @area
      @r.anchor.should eq @area
    end
    
    it "otherwise don't change anchor" do
      @r.anchor.should_receive(:num_locations).and_return(2)
      @area.should_receive(:num_locations).and_return(1)
      @r.add_loc_to_existing_area @area
      @r.anchor.should eq @anchor
    end
  end
  
  describe "add_loc_as_new_area" do
    it "should add a new trip separator area" do      
      @r.loc_to_add = @loc
      TripSeparatorArea.should_receive(:new_with_center).with(@loc).and_return('a')
      @r.areas.should_receive(:push).with('a')
      @r.add_loc_as_new_area
    end
  end
end
