require_relative '../lib/cascade_csv'
require_relative '../lib/data_parser'

desc "Parse file with companies."
task :parse, [] do |_, args|
  DataParser.new('spec/examples/data_test.txt').call
end
