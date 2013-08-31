class TripSeparator::Region < ActiveRecord::Base
  include GeocodeUtil
  attr_accessor :areas, :anchor
    
  def initialize(loc)      
    @anchor = Area.new loc
    @areas = [@anchor] 
  end
  
  def add_loc_if_within_region(loc)
    anchor_dist_sq = dist_sq loc, @anchor
    if anchor_dist_sq > ERROR_RANGE_DIST_UNIT_SQ
      return false
    end
          
    if anchor_dist_sq < SAME_AREA_DIST_UNIT_SQ
      @anchor.add_location loc
    else
      closest, dist = closest_area_and_dist_sq loc      
      if dist < SAME_AREA_DIST_UNIT_SQ
        closest.add_location loc
        @anchor = closest if closest.locs.length > @anchor.locs.length            
      else
        areas.push Area.new loc
      end
    end      
    true
  end
  
  def closest_area_and_dist_sq(loc)
    closest = nil
    closest_dist = Float::MAX
    @areas.each do |area|
      dist = dist_sq area, loc
      if dist < closest_dist
        closest = area
        closest_dist = dist
      end
    end
    [closest, closest_dist]
  end
end
