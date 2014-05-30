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

  def self.bulk_create_and_process(user, locations_attrs)
    num_created = bulk_create(user, locations_attrs)
    TripSeparatorWorker.perform_async(user.id)
    num_created
  end

  def self.bulk_create(user, locations_attrs)
    if locations_attrs.nil? or locations_attrs.length == 0
      num_created = 0
    else
      old_num_locs = user.locations.count
      Location.import locations_attrs.map { |attrs|
        l = Location.new attrs

        # Hack to make it parse the date for the active record import to work
        l.recorded_time = l.recorded_time

        l.calc_n_vector
        l.user = user
        l
      }
      num_created = user.locations.count - old_num_locs
    end
    num_created
  end
end
