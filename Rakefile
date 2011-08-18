require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rake/clean'
#require 'yard'
#
Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.test_files = FileList["test/test*.rb"]
end

task :default => :test
