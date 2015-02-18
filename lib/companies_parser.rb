require_relative 'columns_values'
require_relative 'row_processor'

class CompaniesParser
  def initialize(filename, options = {})
    @filename = filename
    @data_provider = options.fetch(:data_provider) { CascadeCsv }
    @column_values = options.fetch(:column_values) { ColumnsValues.new }
    @row_processor = options.fetch(:row_processor) { RowProcessor.new }
  end

  def call
    companies_data = @data_provider.open(@filename)
    companies_data.each do |row|
      @row_processor.call(row)
    end
  end
end
