require File.expand_path("../../spec_helper", __FILE__)

describe GoogleApi do   
  before do
    @user = create(:user)
    @mock_url = 'https://www.googleapis.com/mock_api_url'
    @api = @user.google_api
  end
  
  describe "underscore keys recursive" do
    it "should underscore all keys recursively" do
      h = {caseChanges: [{aB: []}, {testCASE: 11}], smallBig: "string"}
      e = {case_changes: [{a_b: []}, {test_case: 11}], small_big: "string"}
      @api.underscore_keys_recursive(h).should eq e
    end
  end   
      
  describe "call api paging" do
    it "should call the next page until done and return an aggregate result" do      
      response_p1 = {k1: 'v1', items: [{a:1},{b:2}], nextPageToken: 'p2'}
      response_p2 = {k1: 'v1', items: [{c:3},{d:4}], nextPageToken: 'p3'}
      response_p3 = {k1: 'v1', items: [{e:5}]}
      
      req1 = stub_request(:get, @mock_url)
        .with(:query => {"access_token" => @user.google_auth_token, "x" => 1})
        .to_return(:body => response_p1.to_json, :status => 200)
      
      req2 = stub_request(:get, @mock_url)
        .with(:query => {"access_token" => @user.google_auth_token, 
          "pageToken" => "p2", "x" => 1})
        .to_return(:body => response_p2.to_json, :status => 200)
        
      req3 = stub_request(:get, @mock_url)
        .with(:query => {"access_token" => @user.google_auth_token, 
          "pageToken" => 'p3', "x" => 1})
        .to_return(:body => response_p3.to_json, :status => 200)
        
      @api.call_api(@mock_url, {x:1})
        .should eq k1: 'v1', items: [{a:1},{b:2},{c:3},{d:4},{e:5}]
        
      req1.should have_been_requested
      req2.should have_been_requested
      req3.should have_been_requested
    end
  end
  
  describe "call api single page" do
    it "should do an http request to for call api" do   
      response = {'changesCase' => 'value'}
      returned_val = {changes_case: 'value'}
      
      stub_req = stub_request(:get, @mock_url)
        .with(:query => {"access_token" => @user.google_auth_token})
        .to_return(:body => response.to_json, :status => 200)           
      
      @api.call_api_single_page(@mock_url).should eq(returned_val)
      
      stub_req.should have_been_requested
    end
    
    it "should do an http request to for call api including passed params" do
      stub_req = stub_request(:get, @mock_url)
        .with(:query => {"access_token" => @user.google_auth_token, "a" => 1})
        .to_return(:body => '{}', :status => 200)
      @api.call_api_single_page(@mock_url, {a: 1})
      stub_req.should have_been_requested
    end
    
    it "should request a refresh token if token expiring" do
      @user.google_auth_expires_at = Time.now      
      
      @api.should_receive(:refresh_token).and_return true      
      stub = stub_request(:get, @mock_url)
        .with(:query => {"access_token" => @user.google_auth_token})
        .to_return(:body => '{}', :status => 200)       
      
      @api.call_api_single_page(@mock_url)
      stub.should have_been_requested                
    end
    
    it "should not make request if unable to refresh token" do
      @user.google_auth_expires_at = Time.now      
      @api.should_receive(:refresh_token).and_return false      
      
      # webmock will raise an exception if it requests the url
      @api.call_api_single_page @mock_url         
    end
    
    it "should request refresh token if receives unauthorized" do           
      stub = stub_request(:get, @mock_url)
        .with(:query => {"access_token" => @user.google_auth_token})        
        .to_return(:body => '{}', :status => 401)        
        .then.to_return(:body => '{}', :status => 200)
        
      @api.should_receive(:refresh_token).once.and_return true
              
      @api.call_api_single_page(@mock_url).should eq({})
      
      stub.should have_been_made.times(2)   
    end
    
    it "should return nil but not refresh token a 2nd time if unauthorized" do           
      stub = stub_request(:get, @mock_url)
        .with(:query => {"access_token" => @user.google_auth_token})        
        .to_return(:body => '{}', :status => 401)                    
      
      @api.should_receive(:refresh_token).once.and_return true              
      
      @api.call_api_single_page(@mock_url).should eq nil 
      
      stub.should have_been_made.times(2)
    end
    
    it "should not make a second request if cannot refresh token" do
      @api.should_receive(:refresh_token).and_return false   
      stub = stub_request(:get, @mock_url)
        .with(:query => {"access_token" => @user.google_auth_token})
        .to_return(:body => '{}', :status => 401)       
      
      # webmock will fail if this does an unstubbed request 
      @api.call_api_single_page(@mock_url).should eq nil
    end
  end
  
  describe "refresh token" do
    before do
      @api.should_receive(:client_id).and_return('id')
      @api.should_receive(:client_secret).and_return('secret')  
      
      @refresh_url = 'https://accounts.google.com/o/oauth2/token'
      @refresh_query = {
        refresh_token: @user.google_auth_refresh_token,
        client_id: 'id',
        client_secret: 'secret',
        grant_type: 'refresh_token'       
      }
    end    
    
    it "should call the google oauth server with the refresh token" do       
      response = {
        access_token: 'new_token',
        expires_in: 90,
        token_type: 'Bearer'
      }
      
      time_now = Time.now
      Time.stub!(:now).and_return(time_now)
      
      stub = stub_request(:post, @refresh_url).with(body: @refresh_query)
        .to_return(body: response.to_json, status: 200)        
      
      @api.refresh_token.should eq true
      @user.google_auth_token.should eq 'new_token'
      @user.google_auth_expires_at.should eq time_now + 90.seconds
      @user.new_record?.should eq false
      
      stub.should have_been_requested
    end
    
    it "should return false if receives http unauthorized" do
      stub = stub_request(:post, @refresh_url).with(body: @refresh_query)
        .to_return(body: '{}', status: 401)
      
      @api.refresh_token.should eq false
      
      stub.should have_been_requested
    end
  end  
  
  describe "specific api methods" do
    def expect_call_api(url, params=nil)
      stub = @api.should_receive(:call_api)
      url = 'https://www.googleapis.com/' + url
      if params
        stub.with url, params
      else
        stub.with url
      end
    end      
    
    it "should call correct url for calendar_list" do
      expect_call_api 'calendar/v3/users/me/calendarList'
      @api.calendar_list
    end
    
    it "should call correct url for calendar_events" do
      expect_call_api 'calendar/v3/calendars/me@cal.com/events', {}
      @api.calendar_events 'me@cal.com'
    end
    
    it "should call correct url for calendar_events and pass parameters" do
      expect_call_api 'calendar/v3/calendars/me@cal.com/events', {a: 1}
      @api.calendar_events 'me@cal.com', a: 1
    end    
  end
end
