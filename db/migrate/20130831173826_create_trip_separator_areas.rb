class CreateTripSeparatorAreas < ActiveRecord::Migration
  def change
    create_table :trip_separator_areas do |t|
      t.references :trip_separator_region, index: true
       
      t.decimal :total_x
      t.decimal :total_y
      t.decimal :total_z      
      t.integer :num_locations
      t.datetime :first_time
      t.datetime :last_time
      
      t.decimal :x
      t.decimal :y
      t.decimal :z
      
      t.timestamps
    end
  end
end
