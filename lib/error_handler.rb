class ErrorHandler
  HANDLING_EXCEPTIONS = [IsoCountryCodes::UnknownCodeError, IndexError]
  DEFAULT_ERROR_STORE = ->(row, reason) { @errors ||= []; @errors << [row, reason] }

  def initialize(options={})
    @error_store = options.fetch(:error_store) { DEFAULT_ERROR_STORE }
  end

  # Runs passed block with catching throwing errors and storing it in ErrorStore
  #
  # @param row [Hash] the object retrieved from CSV to store it in case of
  # problems with processing
  def with_errors_handling(row)
    begin
      yield
    rescue *HANDLING_EXCEPTIONS => exception
      @error_store.call(row, exception.to_s)
    end
  end
end
