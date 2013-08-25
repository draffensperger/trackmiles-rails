class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :summary, :null => false, :default => ""
      t.text :description
      t.string :street
      t.string :city
      t.string :postal_code
      t.string :county
      t.string :state
      t.references :country
      t.decimal :latitude
      t.decimal :longitude
      t.decimal :accuracy
      t.string :accuracy_type
        
      t.timestamps
    end
  end
end
