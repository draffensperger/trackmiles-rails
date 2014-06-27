require File.expand_path('../../spec_helper', __FILE__)

describe Location do
  it 'should calc n vector if not already calculated' do
    loc = build(:location)
    loc.should_receive(:as_n_vector)
      .with(loc.latitude, loc.longitude)
      .and_return([1.0, 2.0, 3.0])
    loc.save    
    loc.n_vector_x.should eq 1.0
    loc.n_vector_y.should eq 2.0
    loc.n_vector_z.should eq 3.0
  end
  
  it 'should not calc n-vector if already done' do
    loc = build(:location)
    loc.save
    
    # Don't calc if already done
    loc.should_not_receive(:as_n_vector)
    loc.save
  end

  describe 'bulk create' do
    before do
      @user = create(:user)
    end

    it 'should handle a raw formatted date for recorded_time' do
      date_str = '20131016153201'
      attrs = attributes_for(:loc_no_user1)
      attrs['recorded_time'] = date_str

      Location.bulk_create @user, [attrs]
      @user.locations[0].recorded_time.should eq date_str.to_datetime
    end

    it 'should create locations based on passed attributes' do
      Location.bulk_create(@user, [attributes_for(:loc_no_user1),
                                  attributes_for(:loc_no_user2)]).should eq(2)

      expected_locs = [build(:loc_no_user1), build(:loc_no_user2)]
      @user.locations.length.should == expected_locs.length

      # Set the expected location user_id and id to match the newly saved ones
      expected_locs.each_with_index {|loc, index|
        loc.user_id = @user.id

        matching_loc = @user.locations[index]
        matching_loc.should_not be_nil
        matching_loc.id.should_not be_nil
        loc.id = matching_loc.id
        loc.created_at = matching_loc.created_at
        loc.updated_at = matching_loc.updated_at

        # The locations should calculate the n-vector when loaded.
        loc.calc_n_vector
      }
      @user.locations.each_with_index {|actual, index|
        actual.attributes.each do |k,v|
          expected = expected_locs[index][k]
          if v.is_a?(Float)
            delta = 0.000000000000001
            v.should be_within(delta).of expected
          else
            v.should eq expected
          end
        end
      }
    end

    it 'should not create locations for empty array' do
      @user.locations << create(:loc_no_user1)
      @user.save
      Location.bulk_create(@user, []).should eq(0)
      Location.bulk_create(@user, nil).should eq(0)
    end

    describe 'bulk create and process' do
      it 'should initiate trip separator worker' do
        attrs = attributes_for(:loc_no_user1)
        Location.should_receive(:bulk_create).with(@user, [attrs]).and_return(1)
        expect(@user).to receive(:calc_and_save_trips_async)
        Location.bulk_create_and_process(@user, [attrs]).should eq(1)
      end
    end
  end
end
