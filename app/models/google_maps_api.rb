class GoogleMapsApi
  include GoogleApiHelpers
  
  API_BASE = "http://maps.googleapis.com/maps/api/"
  
  def directions(params)
    get_and_parse API_BASE + "directions/json", params 
    #directions/json?origin=Chicago,IL&destination=Los+Angeles,CA&sensor=false
  end
  
  def distance(origin, destination)
    dir = directions origin: origin, destination: destination, sensor: false
    dir[:routes][0][:legs][0][:distance][:value] if dir
  end
end