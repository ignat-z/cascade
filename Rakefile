require 'rake/testtask'
require_relative 'config/initializers/active_record'
Dir[File.dirname(__FILE__) + '/tasks/*.rake'].each { |task| load task }

Rake::TestTask.new do |task|
  task.pattern = 'spec/**/*_spec.rb'
end

task default: [:test]
