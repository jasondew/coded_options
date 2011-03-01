module CodedOptions
  class Railtie < Rails::Railtie
    initializer "coded_options.initialize" do |app|
      ActiveRecord::Base.send :include, CodedOptions if defined?(ActiveRecord)
    end
  end
end
