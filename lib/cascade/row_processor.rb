require "cascade/complex_fields"
require "cascade/exceptions"
require "cascade/helpers/configuration"
require "cascade/helpers/hash"

module Cascade
  class RowProcessor
    extend Configuration
    using HashRefinements

    DEFAULT_PROCESSOR = ->(value) { value && value.to_s.strip }

    define_setting :use_default_presenter, false
    define_setting :deafult_presenter, -> { DEFAULT_PROCESSOR }

    def initialize(options = {})
      @options          = options
      @columns_matching = options[:columns_matching] || ColumnsMatching.new
    end

    # Iterates through object using columns values supported keys as keys for
    # iterating, then parse it by curresponding parser.
    #
    # @param row [Hash] the object retrieved from CSV
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
      if presenter.nil? && !self.class.use_default_presenter
        raise Cascade::UnknownPresenterType.new
      end
      presenter || self.class.deafult_presenter
    end

    def presenters
      @presenters ||= options.reverse_merge(defined_presenters)
    end

    def self_copy
      self.class.new(options)
    end

    def defined_presenters
      {
        string:             DEFAULT_PROCESSOR,
        currency:           ComplexFields::Currency.new,
        boolean:            ComplexFields::Boolean.new,
        iterable_recursive: ComplexFields::ArrayProcessor.new(self_copy),
        recursive:          self_copy
      }
    end
  end
end
