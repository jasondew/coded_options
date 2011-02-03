require "rubygems"
require "bundler"
Bundler.setup

require "rspec"
require "coded_options"

Rspec.configure do |config|
  config.mock_with :rr
end
