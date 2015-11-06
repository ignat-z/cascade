require "cascade/cascade_csv"
require "cascade/error_handler"
require "cascade/row_processor"

module Cascade
  module Registry
    PUTS_DATA_SAVER = ->(*args) { p args }

    def self.row_processor
      RowProcessor.new
    end

    def self.error_handler
      ErrorHandler.new
    end

    def self.data_saver
      PUTS_DATA_SAVER
    end

    def self.data_provider
      CascadeCsv
    end
  end
end
