require File.expand_path("../lib/coded_options/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "coded_options"
  s.version     = CodedOptions::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jason Dew"]
  s.email       = ["jason.dew@gmail.com"]
  s.homepage    = "http://github.com/jasondew/coded_options"
  s.summary     = "Making options easier"
  s.description = "A gem for making fields with coded values easier"

  s.required_rubygems_version = ">= 1.3.6"

  # lol - required for validation
  s.rubyforge_project         = "coded_options"

  # If you have other dependencies, add them here
  # s.add_dependency "another", "~> 1.2"

  # If you need to check in files that aren't .rb files, add them here
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'

  # If you need an executable, add it here
  # s.executables = ["coded_options"]

  # If you have C extensions, uncomment this line
  # s.extensions = "ext/extconf.rb"
end
