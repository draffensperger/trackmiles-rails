class RenameRecurringEventId < ActiveRecord::Migration
  def change
    rename_column :events, :recurringEventId, :recurring_event_id
  end
end
