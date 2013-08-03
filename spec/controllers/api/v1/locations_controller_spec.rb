require File.expand_path("../../../../spec_helper", __FILE__)

describe Api::V1::LocationsController do
  before do
    @request_json = {
      google_auth_token: "TOKEN",
      locations: [attributes_for(:loc_no_user1), attributes_for(:loc_no_user2)]
    }
  end
  
  it "should create locations based on passed attributes" do
    
  end
end


=begin
    context "badly formed request" do
    it "should return an error for a request without login info" do
      post :index
      assert_response 400
    end
  end
  
  context "invalid auth token" do
    it "should return the forbidden error code for an invalid auth token" do
      post :index, provider: "google", uid: "badUid", token: "badToken"
      assert_response 403
    end
    
    
  end
=end