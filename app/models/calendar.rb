class Calendar < ActiveRecord::Base
  has_many :event
  has_many :calendar_users
  has_many :users, through: :calendar_users
  
  attr_accessible :etag, :gcal_id, :summary, :description, :location, :time_zone  
end
