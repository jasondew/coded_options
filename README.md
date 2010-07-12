CodedOptions
============

Just a way to clean up my normal way to deal with coded options.  Basically,
it turns

> coded_options :state, %w(initial active closed)

into

> STATES = %w(initial active closed)
> STATE_OPTIONS = [["initial", 0], ["active", 1], ["closed", 2]]
>
> def state
>   return unless state_id
>   STATES[state_id]
> end

Enjoy!
