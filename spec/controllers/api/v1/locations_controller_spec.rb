require File.expand_path("../../../../spec_helper", __FILE__)

describe Api::V1::LocationsController do
  before(:all) do
    @token = "TOKEN"
    @request_json = {
      google_auth_token: @token,
      locations: [attributes_for(:loc_no_user1), attributes_for(:loc_no_user2)]
    }
  end
  
  it "should return an http unauthorized error if can't get user from token" do    
    User.should_receive(:find_or_create_for_google_token)
        .with(@token).and_return(nil)          
    #post :bulk_create, @request_json
    #post :bulk_create
    #path = bulk_create_api_v1_locations_path()
    # path = bulk_create_api_v1_locations_path 
    #post '/api/v1/locations/bulk_create'
    #post '/api/v1/bulk_create'
    post :bulk_create
    expect(response.status).to eq(401)
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