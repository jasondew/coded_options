# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "coded_options/version"

Gem::Specification.new do |s|
  s.name        = "coded_options"
  s.version     = CodedOptions::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jason Dew"]
  s.email       = ["jason.dew@gmail.com"]
  s.homepage    = "http://github.com/jasondew/coded_options"
  s.summary     = "Making options easier"
  s.description = "A gem for making fields with coded values easier"

  s.rubyforge_project = "coded_options"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", "~>2.0.0"
  s.add_development_dependency "rr"
end
