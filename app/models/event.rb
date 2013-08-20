class Event < ActiveRecord::Base
  belongs_to :calendar

  serialize :attendees, JSON
  serialize :extended_properties, JSON
  serialize :gadget, JSON
  serialize :reminders, JSON
  serialize :recurrence, JSON
end
