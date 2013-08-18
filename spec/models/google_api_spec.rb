require File.expand_path("../../spec_helper", __FILE__)

describe GoogleApi do   
  before do
    @user = create(:user)
    @mock_url = 'https://www.googleapis.com/mock_api_url'
  end
  
  describe "google api" do
    it "should do an http request to for call api" do   
      response = {'changesCase' => 'value'}
      returned_val = {changes_case: 'value'}
      
      stub_req = stub_request(:get, @mock_url)
        .with(:query => {"access_token" => @user.google_auth_token})
        .to_return(:body => response.to_json, :status => 200)           
      
      @user.google_api.call_api(@mock_url).should eq(returned_val)
      
      stub_req.should have_been_requested
    end
    
    it "should do an http request to for call api including passed params" do
      stub_req = stub_request(:get, @mock_url)
        .with(:query => {"access_token" => @user.google_auth_token, "a" => 1})
        .to_return(:body => '{}', :status => 200)
      @user.google_api.call_api(@mock_url, {a: 1})
      stub_req.should have_been_requested
    end
    
    def expect_call_api(url, params=nil)
      stub = @user.google_api.should_receive(:call_api)
      url = 'https://www.googleapis.com/' + url
      if params
        stub.with url, params
      else
        stub.with url
      end
    end
    
    it "should call correct url for calendar_list" do
      expect_call_api 'calendar/v3/users/me/calendarList'
      @user.google_api.calendar_list
    end
    
    it "should call correct url for calendar_events" do
      expect_call_api 'calendar/v3/calendars/me@cal.com/events', {}
      @user.google_api.calendar_events 'me@cal.com'
    end
    
    it "should call correct url for calendar_events and pass parameters" do
      expect_call_api 'calendar/v3/calendars/me@cal.com/events', {a: 1}
      @user.google_api.calendar_events 'me@cal.com', a: 1
    end    
  end
end
