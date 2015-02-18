require_relative '../spec_helper'
require_relative '../../lib/companies_parser'

describe CompaniesParser do
  let(:filename) { 'spec/examples/companies_test.txt' }

  before do
    @processor_calls_count = 0
    row_processor =  ->(row) { @processor_calls_count += 1 }
    @parser = CompaniesParser.new(filename, row_processor: row_processor)
  end

  it 'calls row processor for each file line' do
    @parser.call
    assert_equal @processor_calls_count, 4
  end
end

