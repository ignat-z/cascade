require 'rake/testtask'
require_relative 'config/initializers/active_record'
load 'tasks/parse.rake'

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

task :default do
  Rake::Task['test'].invoke
end
