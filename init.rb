ActiveSupport.on_load(:action_controller) do
  Base.send :extend, CodedOptions
end
