require File.expand_path("../../spec_helper", __FILE__)

describe Location do
  it "should calc n vector if not already calced" do
    loc = build(:location)
    loc.should_receive(:as_n_vector)
      .with(loc.latitude, loc.longitude)
      .and_return([1.0, 2.0, 3.0])
    loc.save    
    loc.n_vector_x.should eq 1.0
    loc.n_vector_y.should eq 2.0
    loc.n_vector_z.should eq 3.0
  end
  
  it "shouldn't calc n-vector if already done" do
    loc = build(:location)
    loc.save
    
    # Don't calc if already done
    loc.should_not_receive(:as_n_vector)
    loc.save
  end
end
