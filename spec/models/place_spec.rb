require File.expand_path("../../spec_helper", __FILE__)

describe Place do
  describe "address_only" do
    it "should separate out just the address" do
      Place.address_only('1600 Pennsylvania Ave, Washington, DC', 'Washington')
        .should eq  '1600 Pennsylvania Ave'
      Place.address_only('1600 Penn. Ave, Apt 8, Washington, DC', 'Washington')
        .should eq  '1600 Penn. Ave, Apt 8'
    end
  end
end
