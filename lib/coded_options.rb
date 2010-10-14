require "coded_options/base"

module CodedOptions
  class Railtie < Rails::Railtie
    initializer "coded_options.initialize" do |app|
      ActiveRecord::Base.send :extend, CodedOptions
    end
  end
end
