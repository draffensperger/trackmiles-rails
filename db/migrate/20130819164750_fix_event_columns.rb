class FixEventColumns < ActiveRecord::Migration
  def change
    change_column :events, :start_timezone_id, :string
    rename_column :events, :start_timezone_id, :start_timezone    
    change_column :events, :end_timezone_id, :string
    rename_column :events, :end_timezone_id, :end_timezone
          
    change_column :events, :original_start_timezone, :string
    rename_column :events, :ical_uid, :i_cal_uid
      
    add_column :events, :attendees, :string
    add_column :events, :extended_properties, :string
    add_column :events, :gadget, :string
    add_column :events, :reminders, :string
    add_column :events, :anyone_can_add_self, :boolean
    add_column :events, :guests_can_invite_others, :boolean
    add_column :events, :guests_can_modify, :boolean
    add_column :events, :guests_can_see_other_guests, :boolean
  end
end
