module MapQuestApi
  API_BASE = 'http://open.mapquestapi.com/'

  def self.api_call(url, params)
    params[:key] = ENV['MAPQUEST_API_KEY']
    ApiUtil.get_and_parse API_BASE + url, params
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

  def self.distance_and_shape(from, to,
      map_width, map_height, map_zoom, map_lat, map_lng)
    begin
      data = api_call 'directions/v2/route', from: from, to: to, unit: 'k',
                     routeType: 'shortest',
                     mapWidth: map_width, mapHeight: map_height,
                     mapZoom: map_zoom, mapLat: map_lat, mapLng: map_lng
      [data[:route][:distance], data[:route][:shape][:shape_points]]
    rescue
      nil
    end
  end
end