require "awesome_print"

require_relative '../lib/cascade_csv'
require_relative '../lib/data_parser'

desc "Parse data file."
task :parse, [] do |_, args|
  PUTS_DATA_SAVER = ->(*args) { ap args }
  processor = RowProcessor.new(required: ComplexFields::Boolean.new)

  DataParser.new('spec/examples/data_test.txt',
    data_saver: PUTS_DATA_SAVER,
    row_processor: processor).call
end
