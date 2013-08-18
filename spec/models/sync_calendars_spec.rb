require File.expand_path("../../spec_helper", __FILE__)

describe SyncCalendars do  
  describe "sync calendar info" do
    before do
      @user = create(:user)
      @sync = SyncCalendars.new(@user)
        
      @cal1 = build(:calendar1)    
      @cal1_changed = build(:calendar1_changed)    
      @cal_user1 = build(:calendar_user1)
      @cal_user1_changed = build(:calendar_user1_changed)
      
      @cal_attrs = [:etag, :gcal_id, :summary, :access_role, :hidden]
      @cal_user_attrs = [:color_id, :background_color, :foreground_color, 
        :hidden, :selected, :access_role, :primary, :summary_override]
      
      @item1 = {
        kind: 'calendar#calendarListEntry',
        etag: @cal1.etag,
        id: @cal1.gcal_id,
        summary: @cal1.summary,
        description: @cal1.description,
        location: @cal1.location,
        timeZone: @cal1.time_zone,
       
        access_role: @cal_user1.access_role,
        hidden: @cal_user1.hidden,
        summary_override: @cal_user1.summary_override,
        color_id: @cal_user1.color_id,
        background_color: @cal_user1.background_color,
        foreground_color: @cal_user1.foreground_color,
        selected: @cal_user1.selected,
        access_role: @cal_user1.access_role,
        default_reminders: [{method: 'email', minutes: 10}],
        primary: @cal_user1.primary
      }
      
      @item1_changed = {
        kind: 'calendar#calendarListEntry',
        etag: @cal1_changed.etag,
        id: @cal1_changed.gcal_id,
        summary: @cal1_changed.summary,
        description: @cal1_changed.description,
        location: @cal1_changed.location,
        timeZone: @cal1_changed.time_zone,
       
        access_role: @cal_user1_changed.access_role,
        hidden: @cal_user1_changed.hidden,
        summary_override: @cal_user1_changed.summary_override,
        color_id: @cal_user1_changed.color_id,
        background_color: @cal_user1_changed.background_color,
        foreground_color: @cal_user1_changed.foreground_color,
        selected: @cal_user1_changed.selected,
        access_role: @cal_user1_changed.access_role,
        default_reminders: [{method: 'email', minutes: 10}],
        primary: @cal_user1_changed.primary
      }      
    end
    
    describe "create or update calendar from item" do
      it "should create a new calendar from a list item" do
        cal = @sync.sync_calendar_info @item1
        cal.new_record?.should eq false
        cal.attributes.slice(@cal_attrs)
          .should eq @cal1.attributes.slice(@cal_attrs)
      end
      
      it "should update a calendar if one already exists" do
        @cal1.save      
        cal = @sync.sync_calendar_info @item1_changed
        cal.new_record?.should eq false
        cal.id.should eq @cal1.id
        
        cal.attributes.slice(@cal_attrs)
          .should eq @cal1.attributes.slice(@cal_attrs)
      end
    end
    
    describe "create or update calendar user from item" do
      it "should create a new calendar-user from a list item" do
        @cal1.save
        @sync.should_receive(:sync_calendar_info).with(@item1).and_return(@cal1)
        
        cal_user = @sync.sync_calendar_user_info @item1
        cal_user.new_record?.should eq false
        cal_user.user.should eq @user
        cal_user.calendar.should eq @cal1
        cal_user.attributes.slice(@cal_user_attrs)
          .should eq @cal_user1.attributes.slice(@cal_user_attrs)
      end
      
      it "should update a calendar-user if one already exists" do
        @cal1.save
        @cal_user1.user = @user
        @cal_user1.calendar = @cal1
        @cal_user1.save
        
        @sync.should_receive(:sync_calendar_info).with(@item1_changed)
          .and_return(@cal1)
          
        cal_user = @sync.sync_calendar_user_info @item1_changed
        cal_user.new_record?.should eq false
        cal_user.user.should eq @user
        cal_user.calendar.should eq @cal1
        cal_user.attributes.slice(@cal_user_attrs)
          .should eq @cal_user1_changed.attributes.slice(@cal_user_attrs)      
      end
    end
    
    describe "sync calendar list" do
      it "should call calendar list api and sync calendar info" do    
        cal_list = {
          kind: 'calendar#calendarList',
          etag: 'hash',
          items: [{a: 1}, {b: 2}]
        }      
        @user.google_api.should_receive(:calendar_list).and_return cal_list      
        @sync.should_receive(:sync_calendar_user_info).once.ordered.with({a: 1})
        @sync.should_receive(:sync_calendar_user_info).once.ordered.with({b: 2})      
        @sync.sync_calendar_list
      end      
    end
  end
  
  describe "sync calendar events" do
    before do
      
    end
  end
end
