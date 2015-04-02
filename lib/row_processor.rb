require_relative 'complex_fields'

class RowProcessor
  DEFAULT_PROCESSOR = ->(value) { value }

  def initialize(options = {})
    @columns_values = options.delete(:columns_values) || ColumnsValues.new
    @presenters     = options
  end

  # Iterates through object using columns values supported keys as keys for
  # iterating, then parse it by curresponding parser.
  #
  # @param row [Hash] the object retrieved from CSV
  # @return [Hash] the object with parsed columns
  def call(row)
    @columns_values.supported_keys.inject({}) do |result, key|
      raw_value = row.fetch(@columns_values.index(key))
      value     = @presenters.fetch(key.to_sym, DEFAULT_PROCESSOR).call(raw_value)
      result.merge(key => value)
    end
  end
end
