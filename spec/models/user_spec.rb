require File.expand_path("../../spec_helper", __FILE__)

describe User do  
  before(:all) do
    @auth_host = "www.googleapis.com"
    @auth_url = "https://" + @auth_host + "/oauth2/v1/userinfo"
    @provider = "google"
    @uid = "UID"
    @token = "TOKEN" 
    
    WebMock.disable_net_connect!
  end
  
  after(:all) do
    WebMock.allow_net_connect!
  end
  
  def stub_auth_request(status, response)    
    stub_request(:get, @auth_url)
        .with(:query => {"access_token" => @token})
        .to_return(:body => response, :status => status)
  end
  
  describe "get_info_for_auth_token" do
    it "handles invalid credentials" do           
      stub = stub_auth_request 401, 
        {
         "error" => {
          "errors" => [
           {
            "domain" => "global",
            "reason" => "authError",
            "message" => "Invalid Credentials",
            "locationType" => "header",
            "location" => "Authorization"
           }
          ],
          "code" => 401,
          "message" => "Invalid Credentials"
         }
        }
      
      expect(User.get_info_for_auth_token(@provider, @uid, @token))
        .to eq(nil)              
      
      stub.should have_been_requested
    end
    
    it "handles valid credentials" do
      data = {                 
          "id" => "747649134432309132115",
          "email" => "testemail@gmail.com",
          "verified_email" => true,
          "name" => "Test Something",
          "given_name" => "Test",
          "family_name" => "Something",
          "gender" => "male",
          "locale" => "en"
        }         
      stub = stub_auth_request 200, data         
      
      expect(User.get_info_for_auth_token(@provider, @uid, @token))
        .to eq(data)              
      
      stub.should have_been_requested
    end
    
    it "returns nil on timeout and exception" do
      stub_request(:any, @auth_host).to_timeout
      
      expect(User.get_info_for_auth_token(@provider, @uid, @token))
        .to eq(nil)
      
      stub_request(:any, @auth_host).to_raise(StandardError)
      
      expect(User.get_info_for_auth_token(@provider, @uid, @token))
        .to eq(nil)     
    end
  end
end