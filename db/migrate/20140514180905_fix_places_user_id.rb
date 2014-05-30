class FixPlacesUserId < ActiveRecord::Migration
  def change
    remove_column :places, :integer
    add_column :places, :user_id, :integer
  end
end
