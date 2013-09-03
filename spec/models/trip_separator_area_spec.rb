require File.expand_path("../../spec_helper", __FILE__)

describe TripSeparatorArea do
  before do
    @loc = build(:loc_no_user1)
    @loc.calc_n_vector
    @area = TripSeparatorArea.new_with_center @loc
  end
  
  it "should initialize with center" do    
    @area.first_time.should eq @loc.recorded_time
    @area.last_time.should eq @loc.recorded_time
    @area.x.should eq @loc.x
    @area.y.should eq @loc.y
    @area.z.should eq @loc.z
    @area.num_locations.should eq 1
  end
  
  it "should average new points" do
    loc2 = build(:loc_no_user2)
    loc2.calc_n_vector
    @area.add_location loc2
    
    @area.x.should eq ((@loc.x + loc2.x) / 2.0)
    @area.y.should eq ((@loc.y + loc2.y) / 2.0)
    @area.z.should eq ((@loc.z + loc2.z) / 2.0)
    @area.num_locations.should eq 2
  end
end
