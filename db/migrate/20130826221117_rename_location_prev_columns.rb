class RenameLocationPrevColumns < ActiveRecord::Migration
  def change
    rename_column :locations, :prev_location_id, :prev1_location_id
    rename_column :locations, :prev_distance, :prev1_distance
    rename_column :locations, :prev_elapsed, :prev1_elapsed
    rename_column :locations, :calced_speed, :prev1_speed
    
    rename_column :locations, :calced2_speed, :prev2_speed
    rename_column :locations, :calced3_speed, :prev3_speed    
  end
end
