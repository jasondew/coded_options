if ActiveSupport.methods.include?("on_load")
  # rails 3
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.send(:extend, CodedOptions)
  end
else
  # rails 2
  ActiveRecord::Base.send(:extend, CodedOptions)
end
