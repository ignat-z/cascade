require_relative "complex_fields"
require_relative "exceptions"
require_relative "helpers/configuration"

class RowProcessor
  extend Configuration

  DEFAULT_PROCESSOR = ->(value) { value }

  define_setting :use_default_presenter, false
  define_setting :deafult_presenter, -> { DEFAULT_PROCESSOR }

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
      value     = receive_presenter(key).call(raw_value)
      result.merge(key => value)
    end
  end

  private

  def receive_presenter(column_name)
    presenter = @presenters[@columns_matching.column_type(column_name)]
    if presenter.nil? && !self.class.use_default_presenter
      raise Cascade::UnknownPresenterType.new
    end
    presenter || self.class.deafult_presenter
  end

  def defined_presenters
    {
      string:      DEFAULT_PROCESSOR,
      currency:    ComplexFields::Currency.new,
      country_iso: ComplexFields::CountryIso.new,
      boolean:     ComplexFields::Boolean.new,
    }
  end
end
