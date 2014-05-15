require File.expand_path('../../../../spec_helper', __FILE__)

describe Api::V1::LocationsController, :type => :controller do
  it 'should call the location bulk create function and respond with output' do
    date_str = '20131016153201'
    attrs = attributes_for(:loc_no_user1)
    attrs['recorded_time'] = date_str
    attrs.stringify_keys!
    attrs.each {|k,v| attrs[k] = v.to_s}

    token = stub_google_token
    Location.should_receive(:bulk_create)
      .with(user_for_stubbed_login, [attrs]).and_return(1)
    post :bulk_create, google_token: token, locations: [attrs]
    response.should be_success
    response.body.should == {num_created_locations: 1}.to_json
  end
end