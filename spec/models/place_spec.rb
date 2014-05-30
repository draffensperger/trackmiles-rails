require File.expand_path('../../spec_helper', __FILE__)

describe Place do
  describe 'address_only' do
    it 'should separate out just the address' do
      Place.address_only('1600 Pennsylvania Ave, Washington, DC', 'Washington')
        .should eq  '1600 Pennsylvania Ave'
      Place.address_only('1600 Penn. Ave, Apt 8, Washington, DC', 'Washington')
        .should eq  '1600 Penn. Ave, Apt 8'
      Place.address_only('11 Cambridge St, Cambridge, MA', 'Cambridge')
        .should eq  '11 Cambridge St'
    end
  end

  # Make some examples in the factories of places and then search for those
  # within 500m. Have it search for the closest one within 500m.
  describe 'new for location' do

  end
end
