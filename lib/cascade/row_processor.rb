# frozen_string_literal: true

require 'cascade/complex_fields'
require 'cascade/exceptions'
require 'cascade/helpers/hash'

module Cascade
  class RowProcessor
    using HashRefinements

    DEFAULT_PROCESSOR = ->(value) { value&.to_s&.strip }

    def initialize(options = {})
      @options = options
      @ext_presenters = options[:ext_presenters].to_h
      @columns_matching = options.fetch(:columns_matching)
      @use_default_presenter = options.fetch(:use_default_presenter, false)
      @deafult_presenter = options.fetch(:deafult_presenter, DEFAULT_PROCESSOR)
    end

    # Iterates through object using columns values supported keys as keys for
    # iterating, then parse it by the corresponding parser.
    #
    # @param row [Hash] the object retrieved from data parser
    # @return [Hash] the object with parsed columns
    def call(row)
      @columns_matching.supported_keys.inject({}) do |result, key|
        raw_value = row.fetch(@columns_matching.index(key))
        value     = receive_presenter(key).call(raw_value)
        result.merge(key => value)
      end
    end

    private

    attr_reader :options

    def receive_presenter(column_name)
      presenter = presenters[@columns_matching.column_type(column_name)]
      if presenter.nil? && !@use_default_presenter
        raise Cascade::UnknownPresenterType
      end

      presenter || @deafult_presenter
    end

    def presenters
      @presenters ||= @ext_presenters.reverse_merge(predefined_presenters)
    end

    def self_copy
      self.class.new(options)
    end

    def predefined_presenters
      {
        string: DEFAULT_PROCESSOR,
        currency: ComplexFields::Currency.new,
        boolean: ComplexFields::Boolean.new,
        iterable_recursive: ComplexFields::ArrayProcessor.new(self_copy),
        recursive: self_copy
      }
    end
  end
end
