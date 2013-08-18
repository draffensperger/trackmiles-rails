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
  
  def sync_calendar_user_info(item)
    cal = sync_calendar_info item
    
    item.slice! :color_id, :background_color, :foreground_color, :hidden, 
      :selected, :access_role, :primary, :summary_override
        
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
    item.slice! :etag, :gcal_id, :summary, :description, :location, :time_zone
    
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
