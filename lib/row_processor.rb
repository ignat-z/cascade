require_relative 'complex_fields'

class RowProcessor
  DEFAULT_PROCESSOR = ->(value) { value }

  def initialize(options = {})
    @columns_matching = options.delete(:columns_matching) || ColumnsMatching.new
    @presenters       = options.reverse_merge(defined_presenters)
  end

  # Iterates through object using columns values supported keys as keys for
  # iterating, then parse it by curresponding parser.
  #
  # @param row [Hash] the object retrieved from CSV
  # @return [Hash] the object with parsed columns
  def call(row)
    @columns_matching.supported_keys.inject({}) do |result, key|
      raw_value = row.fetch(@columns_matching.index(key))
      value     = @presenters.fetch(@columns_matching.column_type(key),
        DEFAULT_PROCESSOR).call(raw_value)
      result.merge(key => value)
    end
  end

  private

  def defined_presenters
    {
      currency:    ComplexFields::Currency.new,
      country_iso: ComplexFields::CountryIso.new,
      boolean:     ComplexFields::Boolean.new,
    }
  end
end
