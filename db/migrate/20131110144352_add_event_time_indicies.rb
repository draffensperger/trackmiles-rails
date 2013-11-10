class AddEventTimeIndicies < ActiveRecord::Migration
  def change
    add_index :events, :start_datetime_utc
    add_index :events, :end_datetime_utc
  end
end
