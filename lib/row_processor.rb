require_relative 'complex_fields/country_iso'

class RowProcessor
  DEFAULT_PROCESSOR = ->(value) { value }

  def initialize(options = {})
    @columns_values = options.delete(:columns_values) || ColumnsValues.new
    @presenters     = options.reverse_merge(defined_presenters)
  end

  def call(row)
    @columns_values.supported_keys.inject({}) do |result, key|
      raw_value = row[@columns_values.public_send(key)]
      value     = @presenters.fetch(key, DEFAULT_PROCESSOR).call(raw_value)
      result.merge(key => value)
    end
  end

  private

  def defined_presenters
    { country_iso: ComplexFields::CountryIso.new }
  end

end
