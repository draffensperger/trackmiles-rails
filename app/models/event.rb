class Event < ActiveRecord::Base
  belongs_to :calendar

  serialize :attendees
  serialize :extended_properties
  serialize :gadget
  serialize :reminders
  serialize :recurrence
  
  before_save :fix_created_year_zero
  
  # Google Api sometimes sets created year to zero which postgres doesn't like 
  def fix_created_year_zero
    if self.created and self.created.year == 0
      self.created = self.created.change year: 1
    end
  end
end
