require File.expand_path('../../../../spec_helper', __FILE__)

describe Api::V1::LocationsController, :type => :controller do
  it 'should call the location bulk create function and respond with output' do
    date_str = '20131016153201'
    attrs = attributes_for(:loc_no_user1)
    attrs['recorded_time'] = date_str
    attrs.stringify_keys!
    attrs.each {|k,v| attrs[k] = v.to_s}

    token = stub_google_token
    Location.should_receive(:bulk_create_and_process)
      .with(user_for_stubbed_login, [attrs]).and_return(1)
    post :bulk_create, google_token: token, locations: [attrs]
    response.should be_success
    response.body.should == {num_created_locations: 1}.to_json
  end

  describe 'post sample data and correctly separate trips' do
    def post_locations_expect_trips(locs, trips)
      Sidekiq::Testing.inline! do
        post :bulk_create, google_token: stub_google_token, locations: locs
      end
      response.should be_success
      response.body.should == {num_created_locations: locs.length}.to_json

      user_for_stubbed_login.trips.length.should eq trips.length
      trips.each do |t|
        user_for_stubbed_login.trips.should.include? t
      end
    end

    def post_locations_expect_trips_csv(dataset)
      dir = 'spec/data/trip_separation/' + dataset + '/'
      post_locations_expect_trips(
          CSVActiveRecordBuilder::build('Location', dir + 'locations.csv'),
          CSVActiveRecordBuilder::build('Trip', dir + 'trips.csv'))
    end

    it 'should correctly separate trips for sample data' do
      post_locations_expect_trips_csv 'day1'
    end
  end
end