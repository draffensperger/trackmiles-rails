class CalendarUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :calendar
end
