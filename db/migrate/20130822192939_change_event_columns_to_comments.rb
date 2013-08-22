class ChangeEventColumnsToComments < ActiveRecord::Migration
  def change
    change_column :events, :description, :text
    change_column :events, :location, :text
    change_column :events, :recurrence, :text
    change_column :events, :attendees, :text
    change_column :events, :extended_properties, :text
    change_column :events, :gadget, :text
    change_column :events, :reminders, :text
    
    change_column :calendars, :description, :text
  end
end
