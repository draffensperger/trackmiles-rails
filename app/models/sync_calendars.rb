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
  
  def sync_obj(model, attrs, where)
    attrs.slice! *model.attribute_names.to_a.map { |a| a.to_sym }
    obj = model.where(where).take
    if obj
      obj.attributes = attrs
      obj.save
      obj
    else
      obj = model.new attrs
      yield obj if block_given?
      obj.save
      obj
    end
  end
  
  def sync_calendar_event(item, cal)
    item[:gcal_event_id] = item[:id]
    item.delete :id
    
    where = {gcal_event_id: item[:gcal_event_id], calendar_id: cal.id}
    sync_obj Event, item, where do |new_event|
      new_event.calendar = cal
    end
  end  
  
  def sync_calendar_user_info(item)
    cal = sync_calendar_info item
    
    where = {user_id: @user.id, calendar_id: cal.id}
    sync_obj CalendarUser, item, where do |new_cal_user| 
      new_cal_user.user = @user
      new_cal_user.calendar = cal 
    end    
  end
  
  def sync_calendar_info(item)
    item[:gcal_id] = item[:id]
    item.delete :id    
    sync_obj Calendar, item, gcal_id: item[:gcal_id]
  end 
end
