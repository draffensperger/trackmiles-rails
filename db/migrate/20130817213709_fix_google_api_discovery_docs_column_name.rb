class FixGoogleApiDiscoveryDocsColumnName < ActiveRecord::Migration
  def change
    rename_column :google_api_discovery_docs, :verson, :version
  end
end
