require File.expand_path("../../spec_helper", __FILE__)

describe GoogleApi do
  describe "google api" do
    it "should not raise an exception when you call it" do
      @calendar_list_url = 'https://www.googleapis.com/calendar/v3/users/me/calendarList'
      
      create(:calendar_api_discovery_doc)
      stub_google_token
      user = user_for_stubbed_login
      
      result = user.google_api.calendar.calendar_list.list
    end
  end
end
