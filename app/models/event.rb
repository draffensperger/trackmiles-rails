class Event < ActiveRecord::Base
  belongs_to :calendar

  serialize :attendees
  serialize :extended_properties
  serialize :gadget
  serialize :reminders
  serialize :recurrence
  
  before_save :fix_created_year_zero, :calc_utc_start_and_end
  
  # Google Api sometimes sets created year to zero which postgres doesn't like 
  def fix_created_year_zero
    if self.created and self.created.year == 0
      self.created = self.created.change year: 1
    end
  end
  
  def calc_utc_start_and_end
    self.start_datetime_utc = TZInfo::Timezone.get(self.start_time_zone)
      .local_to_utc self.start_date_time if self.start_time_zone
    self.end_datetime_utc = TZInfo::Timezone.get(self.end_time_zone)
      .local_to_utc self.end_date_time if self.end_time_zone
  end
end
