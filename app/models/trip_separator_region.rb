class TripSeparatorRegion < ActiveRecord::Base
  include GeocodeUtil
  has_many :areas, class_name: "TripSeparatorArea", :dependent => :delete_all
  belongs_to :anchor_area, class_name: "TripSeparatorArea"
  alias_attribute :anchor, :anchor_area
     
  SAME_AREA_DIST_M = 160.0  
  SAME_AREA_DIST_KM = SAME_AREA_DIST_M / 1000.0 
  SAME_AREA_DIST_UNIT = SAME_AREA_DIST_M / R_EARTH_M
  SAME_AREA_DIST_UNIT_SQ = SAME_AREA_DIST_UNIT * SAME_AREA_DIST_UNIT
  ERROR_RANGE_DIST_M = 800.0
  ERROR_RANGE_DIST_UNIT = ERROR_RANGE_DIST_M / R_EARTH_M
  ERROR_RANGE_DIST_UNIT_SQ = ERROR_RANGE_DIST_UNIT * ERROR_RANGE_DIST_UNIT   
    
  def set_first_location(loc)      
    self.anchor_area = TripSeparatorArea.new {|a| a.set_first_location loc}
    self.areas = [self.anchor] 
  end
  
  def add_loc_if_within_region(loc)
    anchor_dist_sq = dist_sq loc, self.anchor
    if anchor_dist_sq > ERROR_RANGE_DIST_UNIT_SQ
      return false
    end
          
    if anchor_dist_sq < SAME_AREA_DIST_UNIT_SQ
      self.anchor.add_location loc
    else
      closest, dist = closest_area_and_dist_sq loc      
      if dist < SAME_AREA_DIST_UNIT_SQ
        closest.add_location loc
        self.anchor = closest if closest.num_locations > self.anchor.num_locations       
      else
        areas.push TripSeparatorArea.new {|a| a.set_first_location loc}
      end
    end      
    true
  end
  
  def closest_area_and_dist_sq(loc)
    closest = nil
    closest_dist = Float::MAX
    self.areas.each do |area|
      dist = dist_sq area, loc
      if dist < closest_dist
        closest = area
        closest_dist = dist
      end
    end
    [closest, closest_dist]
  end
end
