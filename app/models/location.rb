class Location < ActiveRecord::Base
  include GeocodeUtil
  
  belongs_to :user
  
  alias_attribute :x, :n_vector_x
  alias_attribute :y, :n_vector_y
  alias_attribute :z, :n_vector_z  
end
