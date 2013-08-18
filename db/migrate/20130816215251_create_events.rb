# Adapted from https://developers.google.com/google-apps/calendar/v3/reference/events#resource
class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :calendar, index: true
      t.string :etag
      t.string :gcal_event_id, :null => false, :default => "", index: true
      t.string :status, :null => false, :default => ""
      t.string :html_link, :null => false, :default => ""
      t.datetime :created, :null => false, :default => Time.now
      t.datetime :updated, :null => false, :default => Time.now
      t.string :summary, :null => false, :default => ""
      t.string :description
      t.string :location
      t.string :creator_id
      t.string :creator_email
      t.string :creator_display_name
      t.boolean :creator_self
      t.string :organizer_id
      t.string :organizer_email
      t.string :organizer_display_name
      t.string :organizer_id
      t.boolean :organizer_self
      t.date :start_date      
      t.datetime :start_datetime      
      t.integer :start_timezone_id
      t.date :end_date
      t.date :end_date_utc
      t.datetime :end_datetime      
      t.integer :end_timezone_id
      t.string :recurrence
      t.string :recurringEventId
      t.date :original_start_date
      t.datetime :original_start_datetime
      t.integer :original_start_timezone
      t.string :transparency
      t.string :visibility
      t.string :ical_uid 
      t.integer :sequence
      t.boolean :end_time_unspecified
      t.string :hangout_link
      
      t.datetime :start_datetime_utc
      t.datetime :end_datetime_utc                     
      
      t.timestamps
    end
    
    add_index :events, [:calendar_id, :gcal_event_id], :unique => true
  end
end
