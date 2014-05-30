class FixMoreEventColumns < ActiveRecord::Migration
  def change
    rename_column :events, :start_datetime, :start_date_time
    rename_column :events, :start_timezone, :start_time_zone
    rename_column :events, :end_datetime, :end_date_time
    rename_column :events, :end_timezone, :end_time_zone    
    rename_column :events, :original_start_date, :original_start_time_date
    rename_column :events, :original_start_datetime, :original_start_time_date_time
    rename_column :events, :original_start_timezone, :original_start_time_time_zone
    add_column :events, :attendees_omitted, :boolean        
  end
end
