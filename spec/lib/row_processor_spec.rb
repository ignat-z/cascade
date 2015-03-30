require_relative '../spec_helper'
require_relative '../../lib/row_processor'

describe RowProcessor do

  context "when parsing row" do
    let(:row) { [:a_value, :b_value, :c_value] }
    let(:keys) { [:a, :b, :c] }
    let(:columns_values) { OpenStruct.new(supported_keys: keys) }

    before do
      { a: 0, b: 1, c: 2 }.each  do |key, index|
        mock(columns_values).index(key) { index }
      end
    end

    it 'collect row values with corresponding keys' do
      processed_row = RowProcessor.new(columns_values: columns_values).call(row)
      assert_equal(processed_row, {a: :a_value, b: :b_value, c: :c_value})
    end
  end

  context 'when presenting row values' do
    let(:row) { ['raw_value'] }
    let(:columns_values)  { OpenStruct.new(supported_keys: [:a]) }
    let(:value_presenter) { ->(raw_value) { 'parsed_value' } }

    before { mock(columns_values).index(:a) { 0 } }

    it 'process field with default presenter if it not specified' do
      parsed_value = RowProcessor.new(columns_values: columns_values).call(row)[:a]
      assert_equal 'raw_value', parsed_value
    end

    it 'process field with specified presenter if it passed' do
      parsed_value = RowProcessor.new(columns_values: columns_values,
        a: value_presenter).call(row)[:a]
      assert_equal 'parsed_value', parsed_value
    end
  end
end

