class GoogleApi
  include ApiUtil
   
  BASE_URL = 'https://www.googleapis.com/'
  CALENDAR_URL = BASE_URL + 'calendar/v3/'
  REFRESH_TOKEN_URL = 'https://accounts.google.com/o/oauth2/token'
  
  def initialize(user)    
    @user = user      
  end
  
  def calendar_list
    call_api CALENDAR_URL + 'users/me/calendarList'
  end
  
  def calendar_events(gcal_id, params={})
    call_api CALENDAR_URL + 'calendars/' + gcal_id + '/events', params
  end
  
  def call_api(url, params={})
    all_items = []
    orig_params = params
    page_token = nil
    
    begin
      params = orig_params
      params[:pageToken] = page_token if page_token

      result = call_api_single_page url, params

      if result
        all_items.push *(result[:items]) if result.key? :items 
        page_token = result[:next_page_token]
      end
    end while result && page_token
    
    result[:items] = all_items if result && result.key?(:items)     
    
    result
  end
  
  def call_api_single_page(url, params={})
    if @user.google_auth_expires_at <= Time.now
      return unless refresh_token
    end
    
    params[:access_token] = @user.google_auth_token    
    begin
      get_and_parse url, params
    rescue RestClient::Unauthorized
      if refresh_token
        begin
          get_and_parse url, params
        rescue RestClient::Unauthorized
          return nil
        rescue Exception => e
          return nil
        end
      else
        return nil
      end
    rescue Exception => e
     return nil
    end   
  end
  
  def refresh_token
    begin
      response = post_and_parse REFRESH_TOKEN_URL, 
        refresh_token: @user.google_auth_refresh_token, 
        client_id: client_id, client_secret: client_secret,
        grant_type: 'refresh_token'
      
      @user.google_auth_token = response[:access_token]
      @user.google_auth_expires_at = Time.now + response[:expires_in].seconds
      @user.save!
      true
    rescue RestClient::Unauthorized
      false
    end
  end
  
  def client_id 
    ENV['OAUTH_CLIENT_ID']
  end
  
  def client_secret
    ENV['OAUTH_CLIENT_SECRET']
  end    
end
