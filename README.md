CodedOptions
============

Usage
-----

Just a way to clean up my normal way to deal with coded options.  Basically,
in a Rails controller, it turns

    coded_options :state, %w(initial active closed)

into

    STATES = {0 => initial, 1 => active, 2 => closed)
    STATE_OPTIONS = [["initial", 0], ["active", 1], ["closed", 2]]

along with the getter and setter methods #state and #state=(new_state) respectively.

The STATE_OPTIONS array is perfect for select tags.  You can also use this in
a plain Ruby object as follows:

    require "coded_options"

    class Foo
      include CodedOptions
      attr_accessor :state_id, :type_id
      coded_options :state => %w(active closed), :type => %w(stupid awesome)
    end

    foo = Foo.new
    foo.type_id = 1
    foo.type          #=> awesome

If the values are important to your application you can pass
a hash instead of an array like so:

    coded_options :gender, {99 => 'other', 1 => 'male', 2 => 'female'}

GENDER will return a hash (the exact hash above), not an array.  GENDER_OPTIONS
will return an array suitable for select tags.  The array will be ordered
numerically by the keys of the hash.

The initial value used defaults to 0 but can be changed via the following two methods:

    coded_options :state => %w(active closed),
                  :initial_value => 42

    CodedOptions.initial_value = 42
    coded_options :state => %w(active closed)

Obviously the first method only affects that statement whereas the second method
is global.

If you want to use this with MongoDB, just add

    include CodedOptions

to your model.

Installation
------------

To install into a Rails 3 app just add this to your `Gemfile`:

    gem "coded_options"

and for Rails 2 apps you will want to install it as a plugin:

    ./script/plugin install git://github.com/jasondew/coded_options.git

Enjoy!
