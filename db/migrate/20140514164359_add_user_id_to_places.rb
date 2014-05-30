class AddUserIdToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :integer, :string
  end
end
