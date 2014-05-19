class AddLastStopAndCurrentRegionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_stop_region_id, :integer
    add_column :users, :current_region_id, :integer
  end
end
