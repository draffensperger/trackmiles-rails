require File.expand_path("../../spec_helper", __FILE__)

describe ApiUtil do
  describe "underscore keys recursive" do
    it "should underscore all keys recursively" do
      h = {caseChanges: [{aB: []}, {testCASE: 11}], smallBig: "string"}
      e = {case_changes: [{a_b: []}, {test_case: 11}], small_big: "string"}
      ApiUtil.underscore_keys_recursive(h).should eq e
    end
  end   
end