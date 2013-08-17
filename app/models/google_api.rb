class GoogleApi
  VERSIONS = {calendar: 'v3'}
  @@client = nil
  @@apis = {}
  
  def initialize(user)    
    @user = user    
    unless @@client
      @@client = Google::APIClient.new      
    end
  end
  
  def authorize_client_for_user
    @@client.authorization.refresh_token = @user.google_auth_refresh_token
    @@client.authorization.access_token = @user.google_auth_token
    if @@client.authorization.refresh_token && client.authorization.expired?
      @@client.authorization.fetch_access_token!
    end
  end
  
  def find_api(api, version)
    @@apis["#{api}:#{versions}"] ||= begin
      doc = GoogleApiDiscoveryDoc.where(api: api, version: version).first
      if doc 
        @@client.register_discovery_document(api, version, doc.doc_json)
      else
        GoogleApiDiscoveryDoc.create api: api, version: version, 
          doc_json: @@client.discovery_document(api, version)
      end
      @@client.discovered_api(api, version)      
    end
  end
  
  # This allows a call like api.calendar.calender_list.list
  def method_missing(api)
    Delegate.new lambda {|resource, args_not_used| 
      Delegate.new lambda {|method, args|
        authorize_client_for_user
        api_method = find_api(api, VERSIONS[api]).send(resource).send(method)         
        @@client.execute(api_method: api_method, parameters: args)
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
