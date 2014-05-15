require 'spec_helper'

describe 'post sample data and correctly separate trips' do
  before do
    WebMock.disable!
  end

  after do
    WebMock.enable!
  end

  def post_locations_expect_trips(locs, expected_trip_attrs)
    Sidekiq::Testing.inline! do
      post bulk_create_api_v1_locations_path, google_token: stub_google_token,
           locations: locs
    end
    response.should be_success
    response.body.should == {num_created_locations: locs.length}.to_json

    get trips_path
    response.should be_success
    assigns(:trips).length.should eq expected_trip_attrs.length

    assigns(:trips).each_with_index do |a, i|
      e = expected_trip_attrs[i]
      a.start_time.should eq(e[:start_time])
      a.end_time.should eq(e[:end_time])
      d = 0.0002
      a.start_place.latitude.should be_within(d).of(e[:start_latitude].to_f)
      a.start_place.longitude.should be_within(d).of(e[:start_longitude].to_f)
      a.end_place.latitude.should be_within(d).of(e[:end_latitude].to_f)
      a.end_place.longitude.should be_within(d).of(e[:end_longitude].to_f)
      a.distance.should be_within(0.1).of(e[:distance].to_f)
    end
  end

  def post_locations_expect_trips_csv(dataset)
    dir = "spec/data/trip_separation/#{dataset}/"
    post_locations_expect_trips CSVUtil.load_as_hashes(dir + 'locations.csv'),
        CSVUtil.load_as_hashes(dir + 'trips.csv')
  end

  it 'should correctly separate trips for sample data' do
    post_locations_expect_trips_csv 'day1'
  end
end