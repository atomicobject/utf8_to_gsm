require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rake/clean'
require 'yard'
require 'bluecloth'

Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.test_files = FileList["test/test*.rb"]
end

YARD::Rake::YardocTask.new do |t|
  t.files = %w[ lib/utf8_to_gsm.rb ]
end

CLEAN.include "pkg"
CLEAN.include "doc"
CLEAN.include ".yardoc"

task :default => :test
