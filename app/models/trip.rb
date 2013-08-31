class Trip < ActiveRecord::Base
  belongs_to :start_place, class_name: 'Place', foreign_key: 'start_place_id'
  belongs_to :end_place, class_name: 'Place', foreign_key: 'end_place_id'
  belongs_to :user
end
