require File.expand_path("../../spec_helper", __FILE__)

describe GoogleMapsApi do    
  it "should get directions url" do
    url = "http://maps.googleapis.com/maps/api/directions/json"        
    response = {routes: [{a: 1}]}
    query = {"origin" => "Chicago,IL", 
            "destination" => "Denver,CO", "sensor" => "false"}
    
    req = stub_request(:get, url).with(:query => query)
        .to_return(:body => response.to_json, :status => 200)
    GoogleMapsApi.directions(query).should eq response       
    req.should have_been_requested
  end
  
  it "should retrieve correct distancet" do    
    GoogleMapsApi.should_receive(:directions).with(
      {origin: "Chicago", destination: "Denver", sensor: false})
      .and_return routes: [
          {legs: [
            {distance: {value: 1615982}}
          ]}
      ]
          
    GoogleMapsApi.distance("Chicago", "Denver").should eq 1615982
  end
end