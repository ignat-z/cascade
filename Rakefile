require "rake/testtask"

Rake::TestTask.new do |task|
  task.libs << "lib"
  task.libs << "spec"
  task.pattern = "spec/**/*_spec.rb"
end

task default: [:test]
