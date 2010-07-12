CodedOptions
============

Just a way to clean up my normal way to deal with coded options.  Basically,
in a Rails controller, it turns

    coded_options :state, %w(initial active closed)

into

    STATES = %w(initial active closed)
    STATE_OPTIONS = [["initial", 0], ["active", 1], ["closed", 2]]
    
    def state
      return unless state_id
      STATES[state_id]
    end

The STATE_OPTIONS array is perfect for select tags.  You can also use this in
a plain Ruby object as follows:

    class Foo
      attr_accessor :state_id, :type_id
      coded_options :state => %w(active closed), :type => %w(stupid awesome)
    end

    foo = Foo.new
    foo.type_id = 1
    foo.type          #=> awesome

Enjoy!
