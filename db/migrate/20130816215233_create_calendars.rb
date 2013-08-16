# Based on https://developers.google.com/google-apps/calendar/v3/reference/calendarList#resource
class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :etag, :null => false, :default => ""
      t.string :gcal_id, :null => false, :default => ""
      t.string :summary, :null => false, :default => ""
      t.string :description
      t.string :location
      t.integer :time_zone_id
      t.string :summary_override            
      
      t.timestamps
    end
    
    add_index :calendars, :gcal_id, :unique => true
  end
end
