require File.expand_path("../../spec_helper", __FILE__)

describe Event do
  it "should handle 0 year created date by setting it to 1" do
    event = build(:event)
    event.created = "0000-12-29T00:00:00.000Z"
    event.save
    event.new_record?.should eq false
    event.created.year.should eq 1
  end
  
  describe "calc_utc_start_and_end" do
    it "should calc utc times when specified for start/end" do
      e = build(:event)    
      
      e.start_date_time = DateTime.new(2013,2,3,  13,30)    
      e.start_time_zone = "America/Denver"
      
      e.end_date_time = DateTime.new(2013,2,3,  15,30)
      e.end_time_zone = "America/Chicago"
      
      e.calc_utc_start_and_end
      e.start_datetime_utc.should eq DateTime.new(2013,2,3,  20,30)
      e.end_datetime_utc.should eq DateTime.new(2013,2,3,  21,30)
    end
    
    it "should calc based on the calendar when start/end not specified" do
      cal = build(:calendar)
      e = build(:event)
      e.calendar = cal
      cal.time_zone = "America/New_York"
            
      e.start_date_time = DateTime.new(2013,2,3,  13,30)                
      e.end_date_time = DateTime.new(2013,2,3,  15,30)
      e.start_time_zone = nil
      e.end_time_zone = nil
      e.calc_utc_start_and_end
      
      e.start_datetime_utc.should eq DateTime.new(2013,2,3,  18,30)
      e.end_datetime_utc.should eq DateTime.new(2013,2,3,  20,30)
    end
    
    it "should handle a nil calendar ok" do
      e = build(:event)
      e.start_time_zone = nil
      e.end_time_zone = nil
      e.calc_utc_start_and_end
    end
  end    
end
