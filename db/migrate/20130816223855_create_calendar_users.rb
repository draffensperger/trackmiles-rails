class CreateCalendarUsers < ActiveRecord::Migration
  def change
    create_table :calendar_users do |t|
      t.references :user, index: true
      t.references :calendar, index: true
      
      t.string :color_id
      t.string :background_color
      t.string :foreground_color
      t.boolean :hidden
      t.boolean :selected
      t.string :access_role
      t.boolean :primary            
      
      t.timestamps
    end
    
    add_index :calendar_users, [:calendar_id, :user_id], :unique => true
  end
end
