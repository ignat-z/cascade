require "cascade/columns_matching"
require "cascade/registry"

module Cascade
  class DataParser
    def initialize(options = {})
      @data_provider  = options.fetch(:data_provider) { Registry.data_provider }
      @row_processor  = options.fetch(:row_processor) { Registry.row_processor }
      @error_handler  = options.fetch(:error_handler) { Registry.error_handler }
      @data_saver     = options.fetch(:data_saver)    { Registry.data_saver }
    end

    # Starts parsing processing with opening file and iterating through each
    # line with parsing and then saves result of each line parsing with
    # DataSaver
    #
    def call
      @data_provider.each_with_index do |row, row_number|
        @error_handler.with_errors_handling(row) do
          @data_saver.call @row_processor.call(row), row_number
        end
      end
    end
  end
end
