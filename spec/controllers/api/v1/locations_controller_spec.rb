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
      
      matching_loc = subject.current_user.locations[index]
      matching_loc.should_not be_nil
      matching_loc.id.should_not be_nil
      loc.id = matching_loc.id
      loc.created_at = matching_loc.created_at
      loc.updated_at = matching_loc.updated_at 
      
      # The locations should calculate the n-vector when loaded.
      loc.calc_n_vector
    }
    subject.current_user.locations.each_with_index {|actual, index|
      actual.attributes.each do |k,v|
        expected = expected_locs[index][k]
        if v.is_a?(Float)
          delta = 0.000000000000001
          v.should be_within(delta).of expected
        else
          v.should eq expected
        end        
      end      
    }
    
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
end