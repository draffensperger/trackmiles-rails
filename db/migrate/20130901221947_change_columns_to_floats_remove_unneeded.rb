class ChangeColumnsToFloatsRemoveUnneeded < ActiveRecord::Migration
  def change        
    remove_column :locations, :prev1_location_id
    remove_column :locations, :prev1_distance
    remove_column :locations, :prev1_elapsed
    remove_column :locations, :prev1_speed
    remove_column :locations, :prev2_location_id
    remove_column :locations, :prev2_distance
    remove_column :locations, :prev2_elapsed
    remove_column :locations, :prev2_speed
    remove_column :locations, :prev3_location_id
    remove_column :locations, :prev3_distance
    remove_column :locations, :prev3_elapsed
    remove_column :locations, :prev3_speed
    
    change_column :locations, :latitude, :float
    change_column :locations, :longitude, :float
    change_column :locations, :altitude, :float
    change_column :locations, :accuracy, :float
    change_column :locations, :speed, :float
    change_column :locations, :bearing, :float
    change_column :locations, :n_vector_x, :float
    change_column :locations, :n_vector_y, :float
    change_column :locations, :n_vector_z, :float
    
    change_column :trips, :distance, :float   
    
    change_column :trip_separator_areas, :total_x, :float
    change_column :trip_separator_areas, :total_y, :float
    change_column :trip_separator_areas, :total_z, :float
    change_column :trip_separator_areas, :num_locations, :float
    change_column :trip_separator_areas, :x, :float
    change_column :trip_separator_areas, :y, :float
    change_column :trip_separator_areas, :z, :float       
  end
end
