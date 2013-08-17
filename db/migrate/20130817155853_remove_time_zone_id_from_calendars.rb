class RemoveTimeZoneIdFromCalendars < ActiveRecord::Migration
  def change
    remove_column :calendars, :time_zone_id
  end
end
