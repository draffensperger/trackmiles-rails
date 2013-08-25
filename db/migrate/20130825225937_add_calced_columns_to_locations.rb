class AddCalcedColumnsToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :prev_location_id, :integer
    add_column :locations, :prev_distance, :decimal
    add_column :locations, :prev_elapsed, :decimal
    add_column :locations, :calced_speed, :decimal
  end
end
