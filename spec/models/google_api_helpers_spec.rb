require File.expand_path("../../spec_helper", __FILE__)

<<<<<<< HEAD
describe ApiHelpers do
=======
describe GoogleApiHelpers do   
>>>>>>> c5971f9c0802f3c56c73255cf46a3eae800c26fd
  describe "underscore keys recursive" do
    it "should underscore all keys recursively" do
      h = {caseChanges: [{aB: []}, {testCASE: 11}], smallBig: "string"}
      e = {case_changes: [{a_b: []}, {test_case: 11}], small_big: "string"}
<<<<<<< HEAD
      ApiHelpers.underscore_keys_recursive(h).should eq e
=======
      GoogleApiHelpers.underscore_keys_recursive(h).should eq e
>>>>>>> c5971f9c0802f3c56c73255cf46a3eae800c26fd
    end
  end   
end