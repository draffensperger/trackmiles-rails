require File.expand_path("../../spec_helper", __FILE__)

describe SyncCalendars do  
  describe "sync calendar info" do
    before do
      @user = create(:user)
      @sync = SyncCalendars.new(@user)
        
      @cal = build(:calendar)    
      @cal_changed = build(:calendar_changed)    
      @cal_user = build(:calendar_user)
      @cal_user_changed = build(:calendar_user_changed)
      
      @cal_attrs = [:etag, :gcal_id, :summary, :access_role, :hidden]
      @cal_user_attrs = [:color_id, :background_color, :foreground_color, 
        :hidden, :selected, :access_role, :primary, :summary_override]
      
      @item = {
        kind: 'calendar#calendarListEntry',
        etag: @cal.etag,
        id: @cal.gcal_id,
        summary: @cal.summary,
        description: @cal.description,
        location: @cal.location,
        timeZone: @cal.time_zone,
       
        access_role: @cal_user.access_role,
        hidden: @cal_user.hidden,
        summary_override: @cal_user.summary_override,
        color_id: @cal_user.color_id,
        background_color: @cal_user.background_color,
        foreground_color: @cal_user.foreground_color,
        selected: @cal_user.selected,
        access_role: @cal_user.access_role,
        default_reminders: [{method: 'email', minutes: 0}],
        primary: @cal_user.primary
      }
      
      @item_changed = {
        kind: 'calendar#calendarListEntry',
        etag: @cal_changed.etag,
        id: @cal_changed.gcal_id,
        summary: @cal_changed.summary,
        description: @cal_changed.description,
        location: @cal_changed.location,
        timeZone: @cal_changed.time_zone,
       
        access_role: @cal_user_changed.access_role,
        hidden: @cal_user_changed.hidden,
        summary_override: @cal_user_changed.summary_override,
        color_id: @cal_user_changed.color_id,
        background_color: @cal_user_changed.background_color,
        foreground_color: @cal_user_changed.foreground_color,
        selected: @cal_user_changed.selected,
        access_role: @cal_user_changed.access_role,
        default_reminders: [{method: 'email', minutes: 0}],
        primary: @cal_user_changed.primary
      }      
    end
    
    describe "create or update calendar from item" do
      it "should create a new calendar from a list item" do
        cal = @sync.sync_calendar_info @item
        cal.new_record?.should eq false
        cal.attributes.slice(@cal_attrs)
          .should eq @cal.attributes.slice(@cal_attrs)
      end
      
      it "should update a calendar if one already exists" do
        @cal.save      
        cal = @sync.sync_calendar_info @item_changed
        cal.new_record?.should eq false
        cal.id.should eq @cal.id
        
        cal.attributes.slice(@cal_attrs)
          .should eq @cal.attributes.slice(@cal_attrs)
      end
    end
    
    describe "create or update calendar user from item" do
      it "should create a new calendar-user from a list item" do
        @cal.save
        @sync.should_receive(:sync_calendar_info).with(@item).and_return(@cal)
        
        cal_user = @sync.sync_calendar_user_info @item
        cal_user.new_record?.should eq false
        cal_user.user.should eq @user
        cal_user.calendar.should eq @cal
        cal_user.attributes.slice(@cal_user_attrs)
          .should eq @cal_user.attributes.slice(@cal_user_attrs)
      end
      
      it "should update a calendar-user if one already exists" do
        @cal.save
        @cal_user.user = @user
        @cal_user.calendar = @cal
        @cal_user.save
        
        @sync.should_receive(:sync_calendar_info).with(@item_changed)
          .and_return(@cal)
          
        cal_user = @sync.sync_calendar_user_info @item_changed
        cal_user.new_record?.should eq false
        cal_user.user.should eq @user
        cal_user.calendar.should eq @cal
        cal_user.attributes.slice(@cal_user_attrs)
          .should eq @cal_user_changed.attributes.slice(@cal_user_attrs)      
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
      @user = create(:user)
      @cal = create(:calendar)
      @cal_user = create(:calendar_user)
      @sync = SyncCalendars.new(@user)      
      
      @event = build(:event)
      @event_changed = build(:event_changed)
      
      @item = {
        kind: "calendar#event",
        etag: @event.etag
        id: @event.gcal_event_id
        status: @event.status
        html_link: @event.html_link
        created: @event.created
        updated: @event.updated
        summary: : @event.summary
        start: {
          date: @event.start_date
        }
        end: {
          date: @event.end_date 
        }        
      }
      
      # Need to fill in parameters
      @item_changed = {
        kind: 'calendar#event',
        etag: @cal_changed.etag,
        id: @cal_changed.gcal_event_id,
        status: @cal_changed.status,
        html_link: @cal_changed.html_link,
        created: @cal_changed.created,
        updated: @cal_changed.datetime,
        summary: @cal_changed.summary,
        description: @cal_changed.description,
        location: @cal_changed.location,
        color_id: @cal_changed.color_id,
        creator: {
          id: @cal_changed.creator_id,
          email: @cal_changed.creator_email,
          display_name: @cal_changed.creator_display_name,
          self: @cal_changed.creator_self
        },
        organizer: {
          id: @cal_changed.organizer_id,
          email: @cal_changed.organizer_email,
          display_name: @cal_changed.organizer_display_name,
          self: @cal_changed.boolean
        },
        start: {
          date_time: @cal_changed.start_date_time,
          time_zone: @cal_changed.start_time_zone
        },
        end: {
          date_time: @cal_changed.start_date_time,
          time_zone: @cal_changed.start_time_zone
        },
        end_time_unspecified: @cal_changed.end_time_unspecified,
        recurrence: [
          "RRULE:FREQ=MONTHLY;COUNT=6;INTERVAL=1;BYMONTHDAY=1"
        ],
        recurring_event_id: @cal_changed.recurring_event_id:,
        originalStartTime: {
          date: @cal_changed.date,
          dateTime: @cal_changed.datetime,
          timeZone: @cal_changed.string
        },
        transparency: @cal_changed.transparency:,
        visibility: @cal_changed.visibility:,
        i_cal_uid: @cal_changed.i_cal_uid,
        sequence: @cal_changed.sequence,
        attendees: [
          {
            id: '1',
            email: 'rando@gmail.com',
            display_name: 'Random attendee',
            organizer: true,
            self: false,
            resource: false,
            optional: true,
            response_status: 'tentative',
            comment: 'Hello comment',
            additional_guests: 50
          }
        ],
        attendees_omitted: @cal_changed.attendees_omitted,
        extended_properties: {
          private: {
            k1: 'v1'
          },
          shared: {
            k2: 'v2'
          }
        },
        hangout_link: @cal_changed.hangout_link:,
        gadget: {
          type: 'some gadget',
          title: 'Hello gadget',
          link: 'https://google.com/gadget/for/cal',
          icon_link: 'https://google.com/icon/for/cal',
          width: 10,
          height: 10,
          display: 'chip',
          preferences: {
            a: '1'
          }
        },
        anyoneCanAddSelf: @cal_changed.boolean,
        guestsCanInviteOthers: @cal_changed.boolean,
        guestsCanModify: @cal_changed.boolean,
        guestsCanSeeOtherGuests: @cal_changed.boolean,
        privateCopy: @cal_changed.boolean,
        locked: @cal_changed.boolean,
        reminders: {
          useDefault: boolean,
          overrides: [
            {
              method: string,
              minutes: integer
            }
          ]
        },
        source: {
          url: @cal_changed.string,
          title: @cal_changed.string
        }
      }
    end
    
    describe "sync event" do
      it "should create a new event for an item" do
        @sync.sync_calendar_event @item, @cal
      end 
    end
  end
end
