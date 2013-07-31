class Location < ActiveRecord::Base
  attr_accessible :accuracy, :altitude, :bearing, :latitude, :longitude, :provider, :recorded_time, :speed
  belongs_to :user
end
