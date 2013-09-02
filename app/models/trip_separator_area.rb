class TripSeparatorArea < ActiveRecord::Base
  include GeocodeUtil
  
  attr_accessor :latitude, :longitude
  
  def set_first_location(loc)          
    self.first_time = loc.recorded_time
    self.last_time = loc.recorded_time
    self.x = loc.x
    self.y = loc.y
    self.z = loc.z
    self.total_x = loc.x
    self.total_y = loc.y
    self.total_z = loc.z
    self.num_locations = 1
  end    
  
  def add_location(loc)
    self.last_time = loc.recorded_time      
    self.num_locations += 1
    calc_new_center loc
  end
  
  def calc_new_center(loc)
    self.total_x += loc.x
    self.total_y += loc.y
    self.total_z += loc.z
    num_locs_f = self.num_locations.to_f
    self.x = self.total_x / num_locs_f
    self.y = self.total_y / num_locs_f
    self.z = self.total_z / num_locs_f  
  end
end
