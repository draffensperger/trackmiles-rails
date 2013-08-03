require File.expand_path("../../spec_helper", __FILE__)

describe User do
  before(:each) do
    @user = build_stubbed(:user)       
    @token = "TOKEN"
    
    @userinfo_valid =            
      {                 
          "id" => "747649134432309132115",
          "email" => @user.email,
          "verified_email" => true,
          "name" => @user.name,
          "given_name" => "IGNORED FOR NOW",
          "family_name" => "IGNORED FOR NOW",
          "gender" => "male",
          "locale" => "en"
      }
    
    @userinfo_invalid =
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
  end
  
  describe "finding or creating a user from an auth token" do
    it "should get the userinfo and then find or create a user with it" do                   
      User.should_receive(:get_userinfo_for_google_token)
        .with(@token).and_return(@userinfo_valid)
        
      User.should_receive(:find_or_create_for_google_userinfo)
        .with(@userinfo_valid).and_return(@user)
      
      User.find_or_create_for_google_token(@token).should eq(@user)
    end
  end
  
  describe "finding or creating a user from google userinfo" do
    def check_find_or_create_for_userinfo() 
      @result = User.find_or_create_for_google_userinfo(@userinfo_valid)
      @result.provider.should eq(@user.provider)      
      @result.uid.should eq(@user.uid)
      @result.name.should eq(@user.name)
      @result.email.should eq(@user.email)
      @result.new_record?.should eq(false)
    end
            
    it "creates a user if it doesn't exist yet" do
      check_find_or_create_for_userinfo()
      
      # A new user should from a Google auth token should have google as its
      # login provider.
      @result.provider.should eq('google')
    end
    
    it "looks up the user if it does exist" do
      created_user = create(:user)
      check_find_or_create_for_userinfo()
      @result.id.should == created_user.id            
    end
    
    it "returns nil if the userinfo is nil" do
      User.find_or_create_for_google_userinfo(nil).should eq(nil)
    end
  end
  
  describe "get google userinfo for an auth token" do    
    before(:all) do
      @auth_host = "www.googleapis.com"
      @auth_url = "https://" + @auth_host + "/oauth2/v1/userinfo"       
      
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
    
    it "handles invalid credentials" do           
      stub = stub_auth_request 401, @userinfo_invalid      
      User.get_userinfo_for_google_token(@token).should eq(nil)      
      stub.should have_been_requested
    end
    
    it "handles valid credentials" do    
      stub = stub_auth_request 200, @userinfo_valid               
      User.get_userinfo_for_google_token(@token).should eq(@userinfo_valid)     
      stub.should have_been_requested
    end
    
    it "returns nil on timeout and exception" do
      stub_request(:any, @auth_host).to_timeout      
      User.get_userinfo_for_google_token(@token).should eq(nil)
      
      stub_request(:any, @auth_host).to_raise(StandardError)      
      User.get_userinfo_for_google_token(@token).should eq(nil)
    end
  end 
end