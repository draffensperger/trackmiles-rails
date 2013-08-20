class Event < ActiveRecord::Base
  belongs_to :calendar
  
  attr_accessible :etag, :gcal_event_id, :status, :html_link, :created, 
    :updated, :summary, :description, :location, :creator_id, :creator_email,
    :creator_display_name, :creator_self, :organizer_id, :organizer_email,
    :organizer_display_name, :organizer_self, :start_date, :start_date_time, 
    :start_time_zone, :end_date, :end_date_time, :end_time_zone, :recurrence, 
    :recurring_event_id, :original_start_time_date, 
    :original_start_time_date_time, :original_start_time_time_zone, 
    :transparency, :visibility, :i_cal_uid, :sequence, :end_time_unspecified, 
    :locked, :hangout_link, :private_copy, :source_url, :source_title,    
    :attendees, :extended_properties, :gadget, :reminders, :anyone_can_add_self,
    :guests_can_invite_others, :guests_can_modify, :guests_can_see_other_guests,
    :attendees_omitted
 
  serialize :attendees, JSON
  serialize :extended_properties, JSON
  serialize :gadget, JSON
  serialize :reminders, JSON
  serialize :recurrence, JSON
end
