class SyncCalendars
  def initialize(user)
    @user = user
    @api = @user.google_api
  end
  
  def sync_calendars
    @api.calendar_list[:items].each do |item|
      cal_user = sync_calendar_user_info item
      sync_events cal_user.calendar
    end
  end  
  
  def sync_events(cal)
    if cal.last_synced
      # Request events last updated 30 seconds before the last synced time
      # to account for possible clock skew 
      events = @api.calendar_events cal.gcal_id, 
        updatedMin: (cal.last_synced - 30.seconds).to_datetime.rfc3339
    else
      events = @api.calendar_events cal.gcal_id
    end
    
    events[:items].each do |item|
      sync_event item, cal
    end
    
    cal.last_synced = Time.now
    cal.last_synced_user_email = @user.email
    cal.save!
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
      begin
        obj.save
        obj
      rescue Exception
        Rails.logger.error $!.backtrace
      end      
    end
  end
  
  def sync_event(item, cal)
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
