qclass CreatePlaceRoles < ActiveRecord::Migration
  def change
    create_table :place_roles do |t|
      t.references :user, index: true
      t.references :place, index: true
      t.string :role, :null => false, :default => ""
      t.string :custom_summary
      t.string :custom_description

      t.timestamps
    end
  end
end
