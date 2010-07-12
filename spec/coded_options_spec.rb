require "spec_helper"
require "active_support/inflector"

describe CodedOptions do

  before(:all) do
    class Foo
      extend CodedOptions
      coded_options :state, %w(initial active closed)
    end

    @foo = Foo.new
  end

  it "should set a constant containing all the values" do
    Foo::STATES.should == %w(initial active closed)
  end

  it "should set a constant containing the ids and values suitable for consumption by select_tag" do
    Foo::STATE_OPTIONS.should == [["initial", 0], ["active", 1], ["closed", 2]]
  end

  it "should define a method for accessing the value based on [name]_id" do
    mock(@foo).state_id.twice { 1 }
    @foo.state.should == "active"
  end

  it "should define a method for accessing the value that returns nil if the id is nil" do
    mock(@foo).state_id { nil }
    @foo.state.should be_nil
  end

end
