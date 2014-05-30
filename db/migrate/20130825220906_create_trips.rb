class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.references :user, index: true
      t.datetime :start_time
      t.datetime :end_time
      t.string :method
      t.integer :start_place_id, index: true
      t.integer :end_place_id, index: true
      t.decimal :distance
      t.string :type
      t.string :purpose
      t.boolean :from_phone
      t.boolean :from_calendar
      t.boolean :reimbursed
      t.boolean :archived
      
      t.timestamps
    end
  end
end
