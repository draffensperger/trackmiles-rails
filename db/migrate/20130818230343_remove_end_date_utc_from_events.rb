class RemoveEndDateUtcFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :end_date_utc
  end
end
