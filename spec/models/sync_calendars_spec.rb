require File.expand_path("../../spec_helper", __FILE__)

describe SyncCalendars do
  before do   
    @user = create(:user)
    @token = stub_google_token(@user)
      
    @cal1 = build(:calendar1)
    @cal2 = build(:calendar2)
    
    @cal_user1 = build(:calendar_user1)
    @cal_user2 = build(:calendar_user2)  
    
    @calendar_list = {
      kind: 'calendar#calendarList',
      etag: 'hash',
      items: [
          {
           kind: 'calendar#calendarListEntry',
           etag: @cal1.etag,
           id: @cal1.gcal_id,
           summary: @cal1.summary,
           accessRole: @cal_user1.access_role,
           hidden: @cal_user1.hidden
          },
          {
            kind: "calendar#calendarListEntry",
            etag: @cal2.etag,
            id: @cal2.gcal_id,
            summary: @cal2.summary,
            description: @cal2.description,
            location: @cal2.location,
            timeZone: @cal2.time_zone,
            summaryOverride: @cal_user2.summary_override,
            colorId: @cal_user2.color_id,
            backgroundColor: @cal_user2.background_color,
            foregroundColor: @cal_user2.foreground_color,
            selected: @cal_user2.selected,
            accessRole: @cal_user2.access_role,
            defaultReminders: [{method: 'email', minutes: 10}],
            primary: @cal_user2.primary
          }
      ]
    }
  end
  
  describe "syncing google calendars for user" do
    it "should create calendars and calendar-users from new Google data" do
      sync = SyncCalendars.new(@user)
      
      stub = stub_request(:get, @calendar_list_url)
        .with(:query => {"access_token" => @token})
        .to_return(:body => @calendar_list.to_json)
      
      sync.sync_calendar_list
      
      stub.should have_been_requested
      
      @user.calendar_users.count.should.eq 2
      @user.calendars.count.should.eq 2
      
      # test that the attributes match
    end
  end
end
