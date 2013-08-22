require File.expand_path("../../spec_helper", __FILE__)

describe Event do
  it "should handle 0 year created date by setting it to 1" do
    event = build(:event)
    event.created = "0000-12-29T00:00:00.000Z"
    event.save
    event.new_record?.should eq false
    event.created.year.should eq 1
  end  
end
