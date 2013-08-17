class CreateGoogleApiDiscoveryDocs < ActiveRecord::Migration
  def change
    create_table :google_api_discovery_docs do |t|
      t.string :api
      t.string :verson
      t.string :doc_json          
    end
  end
end
