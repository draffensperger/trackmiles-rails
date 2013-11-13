describe EmailRegexpValidator do 
  include EmailRegexpValidator 
  it "should have valid_email?" do
    valid_email?("test@test.com").should eq true
    valid_email?("test\n@test.com").should eq false
    valid_email?("asdf").should eq false
    valid_email?("\nabc\n").should eq false
  end
end