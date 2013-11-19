module TripsHelper
  TIME_ZONE = "Eastern Time (US & Canada)"
  
  def trip_date_header(index, trips)
    trip = trips[index]
    if index == 0 ||
      trip.start_time.in_time_zone(TIME_ZONE).to_date !=
      trips[index-1].start_time.in_time_zone(TIME_ZONE).to_date
      
      date = l trip.start_time.in_time_zone(TIME_ZONE)
        .to_date, format: "%A, %B %d, %Y"
      "<hr><b>#{date}</b><br><br>"
    end  
  end
  
  def format_start_time(t)
    start_meridian = meridian t.start_time.in_time_zone(TIME_ZONE)
    end_meridian = meridian t.end_time.in_time_zone(TIME_ZONE)
    if start_meridian == end_meridian
      start_meridian = ""
    end
    l(t.start_time.in_time_zone(TIME_ZONE), format: '%l:%M').strip +
      start_meridian
  end
  
  def format_end_time(t)
    l(t.end_time.in_time_zone(TIME_ZONE), format: '%l:%M').strip + 
      meridian(t.end_time.in_time_zone(TIME_ZONE))
  end
  
  def format_miles(miles)
    if miles
      miles.round(1)
    else
      "-"
    end
  end
  
  def meridian(time)
    l(time, format: '%P').slice 0, 1
    #l(time, format: '%P')
  end
end
