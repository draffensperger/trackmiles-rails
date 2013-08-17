class SyncCalendars
  def initialize(user)
    @user = user
    @token = user.t
  end
  
  def sync_calendar_list
    url = 'https://www.googleapis.com/calendar/v3/users/me/calendarList'
    begin
      JSON.parse RestClient.get url, :params => {:access_token => token}      
    rescue RestClient::Unauthorized
      nil
    rescue => e
      # Other exceptions e.g. network problems will also cause a return of nil.
      nil
    end
  end
  
  def get_google_calendar_list
    
  end
end
