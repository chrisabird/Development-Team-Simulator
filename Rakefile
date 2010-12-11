$LOAD_PATH << './src'

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :sample do
	ruby "-Ilib ./lib/console.rb"
end
