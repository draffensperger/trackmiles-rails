require File.expand_path("../../spec_helper", __FILE__)

describe GoogleApi do
  describe "google api" do
    it "should not raise an exception when you call it" do
      user = create(:user)     
      result = user.google_api.calendar.calendar_list.list
    end
  end
end
