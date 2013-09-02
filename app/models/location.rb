class Location < ActiveRecord::Base
  include GeocodeUtil
  
  belongs_to :user
  before_save :calc_n_vector_if_needed
  
  alias_attribute :x, :n_vector_x
  alias_attribute :y, :n_vector_y
  alias_attribute :z, :n_vector_z
  
  def calc_n_vector_if_needed
    calc_n_vector if n_vector_x.nil?
  end
end
