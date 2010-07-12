require "bundler"
Bundler.setup

require "rspec/core/rake_task"
Rspec::Core::RakeTask.new(:spec)

gemspec = eval(File.read("coded_options.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["coded_options.gemspec"] do
  system "gem build coded_options.gemspec"
  system "gem install coded_options-#{CodedOptions::VERSION}.gem"
end
