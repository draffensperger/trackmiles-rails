class GoogleApi
  VERSIONS = {calendar: 'v3'}
  
  def initialize(user)    
    @client = Google::APIClient.new    
    @client.authorization.refresh_token = user.google_auth_refresh_token
    @client.authorization.access_token = user.google_auth_token
    if @client.authorization.refresh_token && client.authorization.expired?
      @client.authorization.fetch_access_token!
    end    
  end  
  
  # This allows a call like api.calendar.calender_list.list
  def method_missing(service)
    Delegate.new lambda {|resource, args_not_used| 
      Delegate.new lambda {|method, args|
        api = @client.discovered_api service, VERSIONS[service]         
        @client.execute(api_method: api.send(resource).send(method),
          parameters: args)
      }
    }
  end
  
  class Delegate
    def initialize(proc)
      @method_mising_proc = proc
    end
    def method_missing(m, *args)    
      @method_mising_proc.call m, args     
    end
  end  
end
