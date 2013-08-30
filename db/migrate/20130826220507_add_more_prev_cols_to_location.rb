class AddMorePrevColsToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :prev2_location_id, :integer
    add_column :locations, :prev2_distance, :decimal
    add_column :locations, :prev2_elapsed, :decimal
    add_column :locations, :calced2_speed, :decimal
    
    add_column :locations, :prev3_location_id, :integer
    add_column :locations, :prev3_distance, :decimal
    add_column :locations, :prev3_elapsed, :decimal
    add_column :locations, :calced3_speed, :decimal
  end
end
