require_relative "../spec_helper"
require_relative "../../lib/data_parser"

describe DataParser do
  let(:filename) { "spec/examples/data_test.txt" }

  before do
    @processor_calls_count = 0
    @data_saves_count = 0
    row_processor =  ->(_row) { @processor_calls_count += 1 }
    data_saver    =  ->(*)   { @data_saves_count += 1 }
    @parser = DataParser.new(filename, row_processor: row_processor,
      data_saver: data_saver)
  end

  it "calls row processor for each file line" do
    @parser.call
    assert_equal @processor_calls_count, 4
    assert_equal @data_saves_count, 4
  end
end
