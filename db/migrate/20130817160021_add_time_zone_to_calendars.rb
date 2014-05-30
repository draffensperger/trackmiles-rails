class AddTimeZoneToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :time_zone, :string
  end
end
