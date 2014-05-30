class RemoveSummaryOverrideFromCalendars < ActiveRecord::Migration
  def up
    remove_column :calendars, :summary_override
  end

  def down
    add_column :calendars, :summary_override, :string
  end
end
