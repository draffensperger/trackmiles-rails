class Add < ActiveRecord::Migration
  def change
    add_column :locations, :n_vector_x, :decimal
    add_column :locations, :n_vector_y, :decimal
    add_column :locations, :n_vector_z, :decimal
  end
end
