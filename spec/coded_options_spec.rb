require "spec_helper"
require "active_support/inflector"

describe CodedOptions do

  describe "given a hash" do

    before(:all) do
      class Bar
        attr_accessor :state_id, :foo_id

        include CodedOptions
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
      Bar::STATE_OPTIONS = [["initial", 0], ["active", 1], ["closed", 2]]
    end

  end

  describe "changing initial value" do
    it "should use the initial value given when set manually" do
      CodedOptions.initial_value = 1
      CodedOptions.initial_value.should == 1

      class Foo
        include CodedOptions
        attr_accessor :state_id
        coded_options :state, %w(initial active closed)
      end

      Foo::STATE_OPTIONS.should == [["initial", 1], ["active", 2], ["closed", 3]]

      @foo = Foo.new
      @foo.state = "active"
      @foo.state_id.should == 2

      @foo = Foo.new
      @foo.state_id = 3
      @foo.state.should == "closed"

      CodedOptions.initial_value = 0
    end

    it "should use the initial value given when set via the hash" do
      class Foo
        include CodedOptions
        attr_accessor :state_id
        coded_options :state         => %w(initial active closed),
                      :initial_value => 42
        coded_options :bar => %w(quux rand)
      end

      Foo::STATE_OPTIONS.should == [["initial", 42], ["active", 43], ["closed", 44]]
      Foo::BAR_OPTIONS.should == [["quux", 0], ["rand", 1]]

      @foo = Foo.new
      @foo.state = "active"
      @foo.state_id.should == 43

      @foo = Foo.new
      @foo.state_id = 44
      @foo.state.should == "closed"
    end
  end

  describe "allow setting the *_id field via the value" do
    it "should perform a lookup and set the proper id" do
      class Foo
        include CodedOptions
        attr_accessor :state_id
        coded_options :state, %w(initial active closed)
      end

      @foo = Foo.new
      @foo.state = "initial"
      @foo.state_id.should == 0
      @foo.state.should == "initial"
    end
  end

  describe "given a single field" do

    before(:all) do
      class Foo
        include CodedOptions
        coded_options :state, %w(initial active closed)
      end

      @foo = Foo.new
    end

    it "should set a constant containing all the values" do
      Foo::STATES.values.should == %w(initial active closed)
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

  describe "given a single field with a hash for the values" do

    before(:all) do
      class Foo
        include CodedOptions
        coded_options :gender, {99 => 'other', 1 => 'male', 2 => 'female'}
      end

      @foo = Foo.new
    end

    it "should set a constant containing all the values" do
      Foo::GENDERS.should == {99 => 'other', 1 => 'male', 2 => 'female'}
    end

    it "should set a constant containing the ids and values suitable for consumption by select_tag" do
      Foo::GENDER_OPTIONS.should == [["male", 1], ["female", 2], ["other", 99]]
    end

    it "should define a method for accessing the value based on [name]_id" do
      mock(@foo).gender_id.twice { 1 }
      @foo.gender.should == "male"
    end

    it "should define a method for accessing the value that returns nil if the id is nil" do
      mock(@foo).gender_id { nil }
      @foo.gender.should be_nil
    end

  end

end
