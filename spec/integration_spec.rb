# frozen_string_literal: true

require 'spec_helper'
require 'cascade/concerns/statistics_collectible'

describe Cascade do
  let(:date_parser) { ->(value) { Date.parse(value) } }
  let(:int_parser) { ->(value) { Integer(value) } }

  class ExampleDateSaver
    include ::Cascade::StatisticsCollectible

    def initialize
      @result = []
      statistics.register_action(:save, :counter, 0)
    end

    attr_reader :result

    def call(row_description, _row_number)
      @result << row_description.values
      statistics.update(:save)
    end
  end

  let(:data_provider) do
    [
      ['2000-01-01', '1000', 'uno'],
      ['2001-01-01', '2000', 'dos'],
      ['2002-01-01', '3000', 'tres']
    ]
  end

  let(:columns_matching) do
    Cascade::ColumnsMatching.new(content: {
                                   date: :date,
                                   points: :integer,
                                   spanish: :string
                                 })
  end

  let(:row_processor) do
    Cascade::RowProcessor.new(
      columns_matching: columns_matching,
      ext_presenters: { date: date_parser, integer: int_parser }
    )
  end

  let(:data_saver) { ExampleDateSaver.new }

  let(:expected_result) do
    [
      [Date.new(2000, 1, 1), 1000, 'uno'],
      [Date.new(2001, 1, 1), 2000, 'dos'],
      [Date.new(2002, 1, 1), 3000, 'tres']
    ]
  end

  it 'works with empty example' do
    Cascade::DataParser.new(
      data_provider: data_provider,
      data_saver: ->(*_any) {}
    ).call
  end

  it 'checks main cascade work-flow' do
    Cascade::DataParser.new(
      data_provider: data_provider,
      row_processor: row_processor,
      data_saver: data_saver
    ).call

    assert_equal expected_result, data_saver.result
    assert_equal 3, data_saver.statistics.for(:save)
  end
end
