class ColumnsValues
  MULTIPLE_VALUES  = %i()
  SUPPORTED_VALUES = %i(country_iso)

  SUPPORTED_KEYS = SUPPORTED_VALUES - MULTIPLE_VALUES

  def initialize(options = {})
    @content = options.fetch(:content) { parse_content_file }
    init_columns_values_store
  end

  delegate *SUPPORTED_VALUES, to: :columns_values_store
  delegate *MULTIPLE_VALUES,  to: :columns_values_store


  def supported_keys
    SUPPORTED_KEYS
  end

  private
  attr_reader :columns_values_store

  def init_columns_values_store
    @columns_values_store ||= OpenStruct.new(parse_content_file)
  end

  def parse_content_file
    YAML::load(File.open('config/columns_match.yml'))
  end
end
