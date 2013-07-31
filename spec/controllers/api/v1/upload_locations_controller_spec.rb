require 'spec_helper'

describe Api::V1::UploadLocationsController do

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