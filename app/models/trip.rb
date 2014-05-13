class Trip < ActiveRecord::Base
  belongs_to :start_place, class_name: 'Place', foreign_key: 'start_place_id'
  belongs_to :end_place, class_name: 'Place', foreign_key: 'end_place_id'
  belongs_to :user
  
  def find_destination_events
    next_trip = user.trips.where('start_time > ?', self.end_time)
      .order('start_time ASC').first
    if next_trip          
      Event.joins(calendar: [:calendar_users]).where(
        'user_id = :user_id AND ' + 
        'start_datetime_utc < :start_next AND end_datetime_utc > :end_this', 
        user_id: user.id, 
        start_next: next_trip.start_time, end_this: self.end_time)
        .order('start_datetime_utc ASC')
    else
      []
    end
  end
  
  def default_trip_purpose
    purpose = ""
    find_destination_events.each_with_index do |e, i|
      if i > 0
        purpose += ", "
      end
      purpose += e.summary      
    end
    if purpose == ""
      purpose = "-"
    end
    purpose
  end
  
  def distance_in_miles
    self.distance ? self.distance / 1609.34 : nil
  end
  
  def calc_distance
    self.distance =
      MapQuestApi.distance "#{start_place.latitude},#{start_place.longitude}",
        "#{end_place.latitude},#{end_place.longitude}"
  end
end
