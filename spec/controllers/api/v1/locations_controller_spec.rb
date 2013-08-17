require File.expand_path("../../../../spec_helper", __FILE__)

describe Api::V1::LocationsController, :type => :controller do   
  it "should create locations based on passed attributes" do
    post :bulk_create, google_token: stub_google_token,
      locations: [attributes_for(:loc_no_user1), attributes_for(:loc_no_user2)]        
   
    response.should be_success
        
    expected_locs = [build(:loc_no_user1), build(:loc_no_user2)]
    subject.current_user.locations.length.should == expected_locs.length
    
    # Set the expected location user_id and id to match the newly saved ones
    expected_locs.each_with_index {|loc, index|
      loc.user_id = subject.current_user.id
      
      matching_loc_id = subject.current_user.locations[index].id
      matching_loc_id.should_not be_nil
      loc.id = matching_loc_id
    }   
    subject.current_user.locations.should match_array(expected_locs)
    
    response.body.should == {num_created_locations: expected_locs.length}.to_json
  end
  
  it "should not create locations for empty array" do
    token = stub_google_token   
    user_for_stubbed_login.locations << create(:loc_no_user1)    
    user_for_stubbed_login.save
    
    post :bulk_create, google_token: token, locations: []
    response.body.should == {num_created_locations: 0}.to_json  
    
    post :bulk_create, google_token: token, locations: nil
    response.body.should == {num_created_locations: 0}.to_json
  end
  
  it "should not count unsaved locations" do
    Location.any_instance.stub(:save).and_return(nil)
    post :bulk_create, google_token: stub_google_token,
      locations: [attributes_for(:loc_no_user1), attributes_for(:loc_no_user2)]
    response.body.should == {num_created_locations: 0}.to_json
  end
end