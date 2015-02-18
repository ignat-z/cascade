require "awesome_print"

require_relative '../lib/cascade_csv'
require_relative '../lib/data_parser'

desc "Parse file with companies."
task :parse, [] do |_, args|
  PUTS_DATA_SAVER = ->(*args) { ap args }
  DataParser.new('spec/examples/data_test.txt', data_saver: PUTS_DATA_SAVER).call
end
