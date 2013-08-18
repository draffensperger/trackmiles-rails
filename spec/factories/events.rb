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
    start_datetime 7.hour.ago
    start_timezone_id 'America/New_York'    
    end_datetime 1.hour.ago
    end_timezone_id 'America/Chicago'
    recurrence 
    recurringEventId
    original_start_date
    original_start_datetime
    original_start_timezone
    transparency 'transparent'
    visibility 'public'
    ical_uid 'a1@google.com'
    sequence 1
    end_time_unspecified false
    locked false
    hangout_link 'https://google.com/hangout/somewhere?'
    private_copy true
    source_url 'https://google.com/some/source/url'
    source_title 'Some Source'
    
    # These are calculated
    #start_datetime_utc
    #end_datetime_utc 
  end
end
