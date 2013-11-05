class Calendar < ActiveRecord::Base
  has_many :events
  has_many :calendar_users
  has_many :users, through: :calendar_users
end
