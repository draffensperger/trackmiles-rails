# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do   
  factory :calendar do
    etag "calendar-hash1"
    gcal_id "cal1@gmail.com"
    summary "First Calendar"
  end
  
  factory :calendar_changed, class: Calendar do
    etag "calendar-hash2"
    gcal_id 'cal1@gmail.com'
    summary "First Changed"
    description "Added description"
    location "Added location"
    time_zone "America/New_York"
  end
  
  factory :calendar2, class: Calendar do
    etag "calendar-hash2"
    gcal_id "cal2@gmail.com"
    summary "Second Calendar"
  end
end