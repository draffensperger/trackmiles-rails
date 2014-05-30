class AddSummaryOverrideToCalendarUsers < ActiveRecord::Migration
  def change
    add_column :calendar_users, :summary_override, :string
  end
end
