class AddLastSyncedInfoToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :last_synced, :datetime
    add_column :calendars, :last_synced_user_email, :string 
  end
end
