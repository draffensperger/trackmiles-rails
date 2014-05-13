module TripsHelper
  def trip_date_header(index, trips)
    default_tz = "Eastern Time (US & Canada)"
    
    trip = trips[index]
    if index == 0 ||
      trip.start_time.in_time_zone(default_tz).to_date !=
      trips[index-1].start_time.in_time_zone(default_tz).to_date
      
      date = l trip.start_time.in_time_zone(default_tz)
        .to_date, format: "%A, %B %d, %Y"
      "<hr><b>#{date}</b><br><br>"
    end  
  end
  
  def format_start_time(t)
<<<<<<< HEAD
    default_tz = "Eastern Time (US & Canada)"

    start_meridian = meridian t.start_time.in_time_zone(default_tz)
    end_meridian = meridian t.end_time.in_time_zone(default_tz)
    if start_meridian == end_meridian
      start_meridian = ""
    end
    l(t.start_time.in_time_zone(default_tz), format: '%l:%M').strip +
=======
    start_meridian = meridian t.start_time.in_time_zone(TIME_ZONE)
    end_meridian = meridian t.end_time.in_time_zone(TIME_ZONE)
    if start_meridian == end_meridian
      start_meridian = ""
    end
    l(t.start_time.in_time_zone(TIME_ZONE), format: '%l:%M').strip +
>>>>>>> c5971f9c0802f3c56c73255cf46a3eae800c26fd
      start_meridian
  end
  
  def format_end_time(t)
<<<<<<< HEAD
    l(t.end_time.in_time_zone(default_tz), format: '%l:%M').strip +
      meridian(t.end_time.in_time_zone(default_tz))
=======
    l(t.end_time.in_time_zone(TIME_ZONE), format: '%l:%M').strip + 
      meridian(t.end_time.in_time_zone(TIME_ZONE))
>>>>>>> c5971f9c0802f3c56c73255cf46a3eae800c26fd
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
