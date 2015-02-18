require_relative '../spec_helper'
require_relative '../../lib/row_processor'

describe RowProcessor do

  context "when parsing row" do
    let(:row) { [:a_value, :b_value, :c_value] }
    let(:keys) { [:a, :b, :c] }

    it 'collect row values with corresponding keys' do
      columns_values = OpenStruct.new(supported_keys: keys, a: 0, b: 1, c: 2)
      processed_row = RowProcessor.new(columns_values: columns_values).call(row)
      assert_equal(processed_row, {a: :a_value, b: :b_value, c: :c_value})
    end

    it 'raise index error if there is no element with this index  in the row' do
      columns_values = OpenStruct.new(supported_keys: keys, a: 0, b: 1, c: 3)
      assert_raises IndexError do
        RowProcessor.new(columns_values: columns_values).call(row)
      end
    end
  end

  context 'when presenting row values' do
    let(:row) { ['raw_value'] }
    let(:columns_values)  { OpenStruct.new(supported_keys: [:a], a: 0) }
    let(:value_presenter) { ->(raw_value) { 'parsed_value' } }

    it 'process field with default presenter if it not specified' do
      parsed_value = RowProcessor.new(columns_values: columns_values).call(row)[:a]
      assert_equal 'raw_value', parsed_value
    end

    it 'process field with specified presenter if it passed' do
      parsed_value = RowProcessor.new(columns_values: columns_values, a: value_presenter).call(row)[:a]
      assert_equal 'parsed_value', parsed_value
    end
  end
end

