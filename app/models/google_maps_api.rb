module GoogleMapsApi
  API_BASE = "http://maps.googleapis.com/maps/api/"
  
  def self.directions(params)
    ApiHelpers.get_and_parse API_BASE + "directions/json", params
    #directions/json?origin=Chicago,IL&destination=Los+Angeles,CA&sensor=false
  end
  
  def self.distance(origin, destination)
    begin
      dir = directions origin: origin, destination: destination, sensor: false
      dir[:routes][0][:legs][0][:distance][:value]
    rescue
      nil
    end
  end
end