require "spec_helper"
require "active_support/inflector"

describe CodedOptions do

  describe "given a single field" do

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

  describe "given a hash" do

    before(:all) do
      class Bar
        attr_accessor :state_id, :foo_id

        extend CodedOptions
        coded_options :state => %w(initial active closed),
                      :foo   => %w(bar quux baz)
      end

      @bar = Bar.new
      @bar.state_id = 0
      @bar.foo_id = 1
    end

    it "should call setup_coded_options for each field" do
      @bar.state.should == "initial"
      @bar.foo.should == "quux"
    end

  end

end
