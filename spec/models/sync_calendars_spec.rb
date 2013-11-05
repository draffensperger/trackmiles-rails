require File.expand_path("../../spec_helper", __FILE__)

# This uses the Google Apis as documented at:
#https://developers.google.com/google-apps/calendar/v3/reference/calendarList#resource
#https://developers.google.com/google-apps/calendar/v3/reference/events#resource
#https://developers.google.com/google-apps/calendar/v3/reference/events/list

describe SyncCalendars do  
  describe "sync calendar info" do
    before do
      @user = create(:user)
      @sync = SyncCalendars.new(@user)
        
      @cal = build(:calendar)    
      @cal_changed = build(:calendar_changed)    
      @cal_user = build(:calendar_user)
      @cal_user_changed = build(:calendar_user_changed)
      
      @cal_attrs = ['etag', 'gcal_id', 'summary', 'access_role', 'hidden']
      @cal_user_attrs = ['color_id', 'background_color', 'foreground_color', 
        'hidden', 'selected', 'access_role', 'primary', 'summary_override']
      
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
        cal.attributes.slice(*@cal_attrs)
          .should eq @cal.attributes.slice(*@cal_attrs)
      end
      
      it "should update a calendar if one already exists" do
        @cal.save      
        cal = @sync.sync_calendar_info @item_changed
        cal.new_record?.should eq false
        cal.id.should eq @cal.id
        
        cal.attributes.slice(*@cal_attrs)
          .should eq @cal_changed.attributes.slice(*@cal_attrs)
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
        cal_user.attributes.slice(*@cal_user_attrs)
          .should eq @cal_user.attributes.slice(*@cal_user_attrs)
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
        cal_user.attributes.slice(*@cal_user_attrs)
          .should eq @cal_user_changed.attributes.slice(*@cal_user_attrs)      
      end
    end
    
    describe "sync calendar list" do
      it "should call calendar list api and sync calendars' info and events" do    
        cal_list = {
          kind: 'calendar#calendarList',
          etag: 'hash',
          items: [{a: 1}, {b: 2}]
        }
        
        @cal_user.calendar = @cal
        cal2 = build(:calendar2)
        cal_user2 = build(:calendar_user2)
        cal_user2.calendar = cal2
        
        @user.google_api.should_receive(:calendar_list).and_return cal_list      
        
        @sync.should_receive(:sync_calendar_user_info).once.ordered.with({a: 1})
          .and_return @cal_user
        @sync.should_receive(:sync_events).once.ordered.with(@cal)          
          
          
        @sync.should_receive(:sync_calendar_user_info).once.ordered.with({b: 2})
          .and_return cal_user2               
        @sync.should_receive(:sync_events).once.ordered.with(cal2)  
              
        @sync.sync_calendars
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
      @event_all_day = build(:event_all_day)
      @event_changed = build(:event_changed)
      
      @event_attrs = Event.column_names
      ['id', 'calendar_id', 'created_at', 'updated_at', 'start_datetime_utc', 
        'end_datetime_utc'].each do |k|
        @event_attrs.delete k
      end                
      
      @item_all_day = {
        kind: "calendar#event",
        etag: @event_all_day.etag,
        id: @event_all_day.gcal_event_id,
        status: @event_all_day.status,
        html_link: @event_all_day.html_link,
        created: @event_all_day.created,
        updated: @event_all_day.updated,
        summary: @event_all_day.summary,
        start: {
          date: @event_all_day.start_date
        },
        end: {
          date: @event_all_day.end_date 
        }        
      }
      
      @item = {
        kind: "calendar#event",
        etag: @event.etag,
        id: @event.gcal_event_id,
        status: @event.status,
        html_link: @event.html_link,
        created: @event.created,
        updated: @event.updated,
        summary: @event.summary,
        start: {
          date_time: @event.start_date_time,
          time_zone: @event.start_time_zone
        },
        end: {
          date_time: @event.end_date_time,
          time_zone: @event.end_time_zone 
        }        
      }
      
      # Adapted from https://developers.google.com/google-apps/calendar/v3/reference/events
      @item_changed = {
        kind: 'calendar#event',
        etag: @event_changed.etag,
        id: @event_changed.gcal_event_id,
        status: @event_changed.status,
        html_link: @event_changed.html_link,
        created: @event_changed.created,
        updated: @event_changed.updated,
        summary: @event_changed.summary,
        description: @event_changed.description,
        location: @event_changed.location,
        # We don't currently support color_id but it's included here to match
        # the Google event specification. It would vary by user most likely.
        color_id: '1',
        creator: {
          id: @event_changed.creator_id,
          email: @event_changed.creator_email,
          display_name: @event_changed.creator_display_name,
          self: @event_changed.creator_self
        },
        organizer: {
          id: @event_changed.organizer_id,
          email: @event_changed.organizer_email,
          display_name: @event_changed.organizer_display_name,
          self: @event_changed.organizer_self
        },
        start: {
          date_time: @event_changed.start_date_time,
          time_zone: @event_changed.start_time_zone
        },
        end: {
          date_time: @event_changed.end_date_time,
          time_zone: @event_changed.end_time_zone
        },
        end_time_unspecified: @event_changed.end_time_unspecified,
        recurrence: @event_changed.recurrence,
        recurring_event_id: @event_changed.recurring_event_id,
        original_start_time: {
          date: @event_changed.original_start_time_date,
          date_time: @event_changed.original_start_time_date_time,
          time_zone: @event_changed.original_start_time_time_zone
        },
        transparency: @event_changed.transparency,
        visibility: @event_changed.visibility,
        i_cal_uid: @event_changed.i_cal_uid,
        sequence: @event_changed.sequence,
        attendees: @event_changed.attendees,
        attendees_omitted: @event_changed.attendees_omitted,
        extended_properties: @event_changed.extended_properties,
        hangout_link: @event_changed.hangout_link,
        gadget: @event_changed.gadget,
        anyone_can_add_self: @event_changed.anyone_can_add_self,
        guests_can_invite_others: @event_changed.guests_can_invite_others,
        guests_can_modify: @event_changed.guests_can_modify,
        guests_can_see_other_guests: @event_changed.guests_can_see_other_guests,
        private_copy: @event_changed.private_copy,
        locked: @event_changed.locked,
        reminders: @event_changed.reminders,
        source: {
          url: @event_changed.source_url,
          title: @event_changed.source_title
        }
      }
    end        
    
    describe "sync event" do
      it "should create a new event for an item" do
        @cal.save        
        event = @sync.sync_event @item, @cal
        event.new_record?.should eq false
        event.calendar.should eq @cal
        event.attributes.slice(*@event_attrs)
          .should eq @event.attributes.slice(*@event_attrs)
      end
      
      it "should create a new event for an item that's an all-day event" do
        @cal.save        
        event = @sync.sync_event @item_all_day, @cal
        event.new_record?.should eq false
        event.calendar.should eq @cal
        event.attributes.slice(*@event_attrs)
          .should eq @event_all_day.attributes.slice(*@event_attrs)
      end
      
      it "should update an existing event for an item" do
        @cal.save
        @event.calendar = @cal
        @event.save
        
        event = @sync.sync_event @item_changed, @cal
        event.new_record?.should eq false
        event.calendar.should eq @cal
        event.attributes.slice(*@event_attrs)
          .should eq @event_changed.attributes.slice(*@event_attrs)
    
        # Check that the utc fields get set
        event.start_datetime_utc.should eq (
          TZInfo::Timezone.get(event.start_time_zone)
          .local_to_utc event.start_date_time)
        event.end_datetime_utc.should eq (
          TZInfo::Timezone.get(event.end_time_zone)
          .local_to_utc event.end_date_time)    
      end     
    end
    
    describe "sync events from google" do
      it "should call google and sync each event" do
        @cal.save
        @user.google_api.should_receive(:calendar_events).with(@cal.gcal_id)
          .and_return kind: "calendar#calendarList", etag: "hash",
            next_page_token: 'token', items: [{a: 1}, {b: 2}]
            
        @sync.should_receive(:sync_event).with({a: 1}, @cal).ordered.once
        @sync.should_receive(:sync_event).with({b: 2}, @cal).ordered.once
        @sync.sync_events @cal
      end
      
      it "should store last synced info and request with timeMin" do
        @cal.save
        time_now = Time.now
        Time.stub!(:now).and_return(time_now)
        
        @user.google_api.should_receive(:calendar_events).with(@cal.gcal_id)
          .and_return items: []       
        
        @sync.sync_events @cal
        @cal.last_synced.should eq time_now        
        @cal.last_synced_user_email.should eq @user.email
        @cal.changed?.should eq false        
        
        # Give a 30 second gap for possible clock skew between Google and 
        # our server
        time_min_should_be = (time_now - 30.seconds).to_datetime.rfc3339
        
        @user.google_api.should_receive(:calendar_events)
          .with(@cal.gcal_id, timeMin: time_min_should_be)
          .and_return items: []
          
        @sync.sync_events @cal        
      end
      
      it "should handle nil events list without throwing an exception" do
        @user.google_api.should_receive(:calendar_events).with(@cal.gcal_id)
          .and_return nil
        @sync.sync_events @cal
      end 
    end
  end
  
  describe "collapse_subhash" do
    it "should collapse sub" do
      hash = {a: {b: 1, c: 2}}
      SyncCalendars.collapse_subhash! hash, :a
      hash.should eq({a_b: 1, a_c: 2})
    end
   
    it "should handle key not there without exception" do
      hash = {a: 1}
      SyncCalendars.collapse_subhash! hash, :not_there
      hash.should eq({a: 1})
    end
  end
end
