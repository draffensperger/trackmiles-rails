class SyncCalendars
  def initialize(user)
    @user = user
  end
  
  def sync_calendar_list
    @user.google_api.calendar_list[:items].each do |item|
      sync_calendar_user_info item
    end
  end  
  
  def sync_calendar_events(cal)
    
  end
  
  def sync_calendar_event(item, cal)
    item[:gcal_event_id] = item[:id]
    item.delete :id
    item.slice! *Event.attribute_names.to_a.map { |a| a.to_sym }
    
    event = Event.find_by_gcal_event_id_and_calendar_id(
      item[:gcal_event_id], cal.id)
    
    if event
      puts 'event'
    end
    
    if event
      event.assign_attributes item
      event.save
      event
    else
      event = Event.new item
      event.calendar = cal
      event.save
      event
    end    
  end
  
  def sync_calendar_user_info(item)
    cal = sync_calendar_info item
    
    item.slice! *CalendarUser.attribute_names.to_a.map { |a| a.to_sym }
        
    cal_user = CalendarUser.find_by_user_id_and_calendar_id @user.id, cal.id 
    
    if cal_user      
      cal_user.assign_attributes item
    else
      cal_user = CalendarUser.new item
      cal_user.user = @user
      cal_user.calendar = cal           
    end
        
    cal_user.save
    cal_user
  end
  
  def sync_calendar_info(item)
    item[:gcal_id] = item[:id]
    item.delete :id 
    
    item.slice! *Calendar.attribute_names.to_a.map { |a| a.to_sym }
    
    cal = Calendar.find_by_gcal_id item[:gcal_id]
    if cal
      cal.assign_attributes item
      cal.save
      cal
    else
      Calendar.create item
    end
  end 
end
