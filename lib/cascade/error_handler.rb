require "cascade/helpers/configuration"

module Cascade
  class ErrorHandler
    extend Configuration

    define_setting :raise_parse_errors, false

    HANDLING_EXCEPTIONS = [IndexError]
    DEFAULT_ERROR_STORE = lambda do |row, exception|
      @errors ||= []
      @errors << [row, exception.to_s]
    end

    def initialize(options = {})
      @error_store = options.fetch(:error_store) { DEFAULT_ERROR_STORE }
      @handling_exceptions = options.fetch(:handling_exceptions) do
        HANDLING_EXCEPTIONS
      end
    end

    # Runs passed block with catching throwing errors and storing in ErrorStore
    #
    # @param row [Hash] the object retrieved from CSV to store it in case of
    # problems with processing
    def with_errors_handling(row)
      yield
    rescue *@handling_exceptions => exception
      @error_store.call(row, exception)
      raise exception if self.class.raise_parse_errors
    end
  end
end
