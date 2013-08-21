class Event < ActiveRecord::Base
  belongs_to :calendar

  serialize :attendees
  serialize :extended_properties
  serialize :gadget
  serialize :reminders
  serialize :recurrence
end
