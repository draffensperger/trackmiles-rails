class TripSeparatorRegion < ActiveRecord::Base
  include GeocodeUtil
  belongs_to :user
  has_many :areas, class_name: "TripSeparatorArea", :dependent => :delete_all
  belongs_to :anchor_area, class_name: "TripSeparatorArea"
  alias_attribute :anchor, :anchor_area
  
  attr_accessor :loc_to_add
     
  def self.new_with_center(loc)
    TripSeparatorRegion.new {|r|
      r.anchor = TripSeparatorArea.new_with_center loc
      r.areas = [r.anchor]
    }    
  end
     
  ERROR_RANGE_DIST_M = 800.0
  ERROR_RANGE_DIST_UNIT = ERROR_RANGE_DIST_M / R_EARTH_M
  ERROR_RANGE_DIST_UNIT_SQ = ERROR_RANGE_DIST_UNIT * ERROR_RANGE_DIST_UNIT   
  def within_region_threshold?(dist_sq)
    dist_sq <= ERROR_RANGE_DIST_UNIT_SQ
  end
  
  SAME_AREA_DIST_M = 160.0
  SAME_AREA_DIST_KM = SAME_AREA_DIST_M / 1000.0 
  SAME_AREA_DIST_UNIT = SAME_AREA_DIST_M / R_EARTH_M
  SAME_AREA_DIST_UNIT_SQ = SAME_AREA_DIST_UNIT * SAME_AREA_DIST_UNIT    
  def within_area_threshold?(dist_sq)
    dist_sq <= SAME_AREA_DIST_UNIT_SQ
  end

  def add_loc_if_within_region(loc)    
    @loc_to_add = loc
    within_region = within_region_threshold? anchor_dist
    add_loc_to_region if within_region              
    within_region
  end
  
  def anchor_dist
    @anchor_dist ||= dist_sq @loc_to_add, self.anchor    
  end
  
  def add_loc_to_region
    if within_area_threshold? anchor_dist
      self.anchor.add_location @loc_to_add
    else
      add_loc_to_closest_or_new_area 
    end
  end
  
  def add_loc_to_closest_or_new_area
    closest, dist = find_closest_and_dist_sq @loc_to_add, areas   
    if within_area_threshold? dist
      add_loc_to_existing_area closest       
    else
      add_loc_as_new_area
    end
  end
  
  def add_loc_to_existing_area(area)
    area.add_location @loc_to_add
    self.anchor = area if area.num_locations > self.anchor.num_locations
  end
  
  def add_loc_as_new_area
    areas.push TripSeparatorArea.new_with_center @loc_to_add
  end
end
