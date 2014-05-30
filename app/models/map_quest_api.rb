module MapQuestApi
  API_BASE = 'http://open.mapquestapi.com/'

  def self.api_call(url, params)
    params[:key] = ENV['MAPQUEST_API_KEY']
    ApiHelpers.get_and_parse API_BASE + url, params
  end

  def self.distance(from, to)
    begin
      dir = api_call 'directions/v2/route', from: from, to: to, unit: 'k',
                     routeType: 'shortest'
      dir[:route][:distance]
    rescue
      nil
    end
  end
end