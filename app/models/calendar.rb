class Calendar < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :events
end
