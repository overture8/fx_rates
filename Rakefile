require "bundler/gem_tasks"
require 'rake/testtask'
Dir.glob('lib/tasks/*.rake').each { |r| load r}

Rake::TestTask.new do |t|
  t.test_files = FileList['test/test_*.rb']
end
task :default => :test
