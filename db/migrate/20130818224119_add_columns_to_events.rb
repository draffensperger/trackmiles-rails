class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :private_copy, :boolean
    add_column :events, :locked, :boolean
    add_column :events, :source_url, :string
    add_column :events, :source_title, :string
  end
end
