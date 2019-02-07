# frozen_string_literal: true

require 'spec_helper'
require 'cascade/data_parser'

describe Cascade::DataParser do
  def described_class
    Cascade::DataParser
  end

  class FakeDataProvider
    def self.open(_any)
      [
        ['Sally Whittaker', '2018', 'McCarren House', '312',
         '3.75', 'France', '+', '123.123'],
        ['Jeff Smith', '2018', 'Prescott House', '17-D', '3.20',
         'Austria', '45.12']
      ]
    end
  end

  let(:filename) { 'spec/examples/data_test.txt' }
  let(:data_provider) { FakeDataProvider.open(filename) }

  before do
    @processor_calls_count = 0
    @data_saves_count = 0
    row_processor =  ->(_row) { @processor_calls_count += 1 }
    data_saver    =  ->(*) { @data_saves_count += 1 }
    @parser = described_class.new(row_processor: row_processor,
                                  data_saver: data_saver,
                                  data_provider: data_provider)
  end

  it 'calls row processor for each file line' do
    @parser.call
    assert_equal @processor_calls_count, 2
    assert_equal @data_saves_count, 2
  end
end
