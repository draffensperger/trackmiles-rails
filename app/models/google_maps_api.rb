module GoogleMapsApi
  API_BASE = "http://maps.googleapis.com/maps/api/"
  
  def self.directions(params)
<<<<<<< HEAD
    ApiHelpers.get_and_parse API_BASE + "directions/json", params
=======
    GoogleApiHelpers.get_and_parse API_BASE + "directions/json", params 
>>>>>>> c5971f9c0802f3c56c73255cf46a3eae800c26fd
    #directions/json?origin=Chicago,IL&destination=Los+Angeles,CA&sensor=false
  end
  
  def self.distance(origin, destination)
<<<<<<< HEAD
    begin
      dir = directions origin: origin, destination: destination, sensor: false
      dir[:routes][0][:legs][0][:distance][:value]
    rescue
=======
    dir = directions origin: origin, destination: destination, sensor: false
    begin
      dir[:routes][0][:legs][0][:distance][:value]
    rescue NoMethodError
>>>>>>> c5971f9c0802f3c56c73255cf46a3eae800c26fd
      nil
    end
  end
end