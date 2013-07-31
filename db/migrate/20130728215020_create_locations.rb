class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :user_id
      t.datetime :recorded_time
      t.string :provider
      t.decimal :latitude
      t.decimal :longitude
      t.decimal :altitude
      t.decimal :accuracy
      t.decimal :speed
      t.decimal :bearing

      t.timestamps
    end
  end
end
