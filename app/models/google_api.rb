class GoogleApi
  BASE_URL = 'https://www.googleapis.com/'
  CALENDAR_URL = BASE_URL + 'calendar/v3/'
  
  def initialize(user)    
    @user = user      
  end
  
  def call_api(url, params={})
    params[:access_token] = @user.google_auth_token
    JSON.parse(RestClient.get url, :params => params).underscore_keys_recursive
  end
  
  def calendar_list
    call_api CALENDAR_URL + 'users/me/calendarList'
  end
  
  def calendar_events(gcal_id, params={})
    call_api CALENDAR_URL + 'calendars/' + gcal_id + '/events', params
  end     
end
