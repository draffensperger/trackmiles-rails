class CreateTripSeparatorRegions < ActiveRecord::Migration
  def change
    create_table :trip_separator_regions do |t|
      t.references :user, index: true
      t.integer :anchor_area_id
      t.datetime :last_time
      
      t.timestamps
    end
  end
end
