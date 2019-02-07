# frozen_string_literal: true

require 'spec_helper'
require 'cascade/row_processor'

describe Cascade::RowProcessor do
  def described_class
    Cascade::RowProcessor
  end

  context 'when parsing row' do
    let(:row) { %i[a_value b_value c_value] }
    let(:keys) { %i[a b c] }
    let(:columns_matching) { OpenStruct.new(supported_keys: keys) }

    before do
      keys.each_with_index do |key, index|
        stub(columns_matching).index(key) { index }
        stub(columns_matching).column_type(key) { :string }
      end
    end

    it 'collect row values with corresponding keys' do
      processed_row = described_class.new(columns_matching:
        columns_matching).call(row)
      assert_equal(processed_row, a: 'a_value', b: 'b_value', c: 'c_value')
    end
  end

  context 'when presenting row values' do
    let(:row) { ['raw_value'] }
    let(:columns_matching)  { OpenStruct.new(supported_keys: [:a]) }
    let(:value_presenter) { ->(_raw_value) { 'parsed_value' } }

    before do
      stub(columns_matching).index(:a) { 0 }
      stub(columns_matching).column_type(:a) { :presenter }
    end

    context 'when curresponding presenter passed' do
      it 'process field with specified presenter' do
        parsed_value = described_class.new(
          columns_matching: columns_matching,
          ext_presenters: { presenter: value_presenter }
        ).call(row)[:a]
        assert_equal 'parsed_value', parsed_value
      end
    end

    context 'when curresponding presenter not passed' do
      context 'when use_default_presenter is false' do
        it 'process field and rise error' do
          assert_raises(Cascade::UnknownPresenterType) do
            described_class.new(columns_matching: columns_matching).call(row)
          end
        end
      end

      context 'when use_default_presenter is true' do
        it 'process field with default presenter' do
          parsed_value = described_class.new(
            columns_matching: columns_matching,
            use_default_presenter: true,
            deafult_presenter: value_presenter
          ).call(row)[:a]
          assert_equal 'parsed_value', parsed_value
        end
      end
    end
  end
end
