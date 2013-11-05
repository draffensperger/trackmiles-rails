# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    etag 'hash'
    gcal_event_id 'a1'
    status 'confirmed'
    html_link 'https://www.google.com/calendar/event?eid=a1b1'
    created Time.now
    updated Time.now
    summary "My Event"
    start_date_time 6.hours.ago
    start_time_zone 'America/New_York'    
    end_date_time 2.hours.ago
    end_time_zone 'America/Chicago'
  end
  
  factory :event_all_day, class: Event do
    etag 'hash'
    gcal_event_id 'a1'
    status 'confirmed'
    html_link 'https://www.google.com/calendar/event?eid=C1b1'
    created Time.now
    updated Time.now
    summary "My Event All Day Long"
    start_date 2.days.ago
    end_date 1.day.ago
  end
  
  factory :event_changed, class: Event do
    etag 'hash'
    gcal_event_id 'a1'
    status 'tenative'
    html_link 'https://www.google.com/calendar/event?eid=a1b1'
    created Time.now
    updated Time.now
    summary "My Event Changd"
    
    description "Added Description"
    location "Now in Boston, MA"
    creator_id '12'
    creator_email 'me@gmail.com'
    creator_display_name 'Me Tester'
    creator_self true
    organizer_id '1'
    organizer_email 'organized@gmail.com'
    organizer_display_name 'Organized Tester'
    organizer_self false    
    start_date_time 7.hours.ago
    start_time_zone 'America/New_York'    
    end_date_time 1.hour.ago
    end_time_zone 'America/Chicago'
    recurrence([
        "RRULE:FREQ=MONTHLY;COUNT=6;INTERVAL=1;BYMONTHDAY=1"
      ])
    recurring_event_id 9
    original_start_time_date 3.days.ago
    original_start_time_date_time 4.days.ago
    original_start_time_time_zone 'America/Anchorage'
    transparency 'transparent'
    visibility 'public'
    i_cal_uid 'a1@google.com'
    add_attribute :sequence, 22 #needed because sequence is a method in factory
    end_time_unspecified false
    locked false
    hangout_link 'https://google.com/hangout/somewhere?'
    private_copy true
    source_url 'https://google.com/some/source/url'
    source_title 'Some Source'
        
    anyone_can_add_self true
    guests_can_invite_others false
    guests_can_modify true
    guests_can_see_other_guests false
    
    attendees_omitted false
    
    attendees([
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
      ])
        
    extended_properties({
        private: {
          k1: 'v1'
        },
        shared: {
          k2: 'v2'
        }
      })
    
    gadget({
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
        })
   
    reminders({
          use_default: false,
          overrides: [
            {
              method: 'some method',
              minutes: 55
            }
          ]
        })
  end
end
