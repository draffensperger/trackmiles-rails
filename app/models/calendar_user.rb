class CalendarUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :calendar
  
  attr_accessible :color_id, :background_color, :foreground_color, :hidden,
    :selected, :access_role, :primary, :summary_override
end
