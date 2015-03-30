require_relative 'complex_fields/country_iso'
require_relative 'complex_fields/currency'

class RowProcessor
  DEFAULT_PROCESSOR = ->(value) { value }

  def initialize(options = {})
    @columns_values = options.delete(:columns_values) || ColumnsValues.new
    @presenters     = options.reverse_merge(defined_presenters)
  end

  # Iterates through object using columns values supported keys as keys for
  # iterating, then parse it by curresponding parser.
  #
  # @param row [Hash] the object retrieved from CSV
  # @return [Hash] the object with parsed columns
  def call(row)
    @columns_values.supported_keys.inject({}) do |result, key|
      raw_value = row.fetch(@columns_values.index(key))
      value     = @presenters.fetch(key, DEFAULT_PROCESSOR).call(raw_value)
      result.merge(key => value)
    end
  end

  private

  def defined_presenters
    { currency:    ComplexFields::Currency.new,
      country_iso: ComplexFields::CountryIso.new, }
  end

end
