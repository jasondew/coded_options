require "spec_helper"
require "active_support/inflector"

describe CodedOptions do

  before(:all) do
    extend CodedOptions
    coded_options :state, %w(initial active closed)
  end

  it "should set a constant containing all the values" do
    CodedOptions::Constants::STATES.should == %w(initial active closed)
  end

  it "should set a constant containing the ids and values suitable for consumption by select_tag" do
    CodedOptions::Constants::STATE_OPTIONS.should == [["initial", 0], ["active", 1], ["closed", 2]]
  end

  it "should define a method for accessing the value based on [name]_id" do
    mock(self).state_id.twice { 1 }
    state.should == "active"
  end

  it "should define a method for accessing the value that returns nil if the id is nil" do
    mock(self).state_id { nil }
    state.should be_nil
  end

end
