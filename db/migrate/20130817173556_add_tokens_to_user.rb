class AddTokensToUser < ActiveRecord::Migration
  def change
    add_column :users, :google_auth_token, :string
    add_column :users, :google_auth_refresh_token, :string
    add_column :users, :google_auth_expires_at, :datetime
  end
end
