# frozen_string_literal: true

module Cascade
  class ErrorHandler
    HANDLING_EXCEPTIONS = [IndexError].freeze
    DEFAULT_ERROR_STORE = lambda do |row, exception|
      @errors ||= []
      @errors << [row, exception.to_s]
    end

    def initialize(options = {})
      @error_store = options.fetch(:error_store) { DEFAULT_ERROR_STORE }
      @raise_parse_errors = options.fetch(:raise_parse_errors, false)
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
      raise exception if @raise_parse_errors
    end
  end
end
