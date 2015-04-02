require_relative '../spec_helper'
require_relative '../../lib/row_processor'

describe RowProcessor do

  context "when parsing row" do
    let(:row) { [:a_value, :b_value, :c_value] }
    let(:keys) { [:a, :b, :c] }
    let(:columns_matching) { OpenStruct.new(supported_keys: keys) }

    before do
      keys.each_with_index  do |key, index|
        stub(columns_matching).index(key) { index }
        stub(columns_matching).column_type(key) { :string }
      end

    end

    it 'collect row values with corresponding keys' do
      processed_row = RowProcessor.new(columns_matching:
        columns_matching).call(row)
      assert_equal(processed_row, {a: :a_value, b: :b_value, c: :c_value})
    end
  end

  context 'when presenting row values' do
    let(:row) { ['raw_value'] }
    let(:columns_matching)  { OpenStruct.new(supported_keys: [:a]) }
    let(:value_presenter) { ->(raw_value) { 'parsed_value' } }

    before do
      stub(columns_matching).index(:a) { 0 }
      stub(columns_matching).column_type(:a) { :presenter }
    end

    it 'process field with default presenter if it not specified' do
      parsed_value = RowProcessor.new(columns_matching:
        columns_matching).call(row)[:a]
      assert_equal 'raw_value', parsed_value
    end

    it 'process field with specified presenter if it passed' do
      parsed_value = RowProcessor.new(columns_matching: columns_matching,
        presenter: value_presenter).call(row)[:a]
      assert_equal 'parsed_value', parsed_value
    end
  end
end

