class ErrorHandler
  HANDLING_EXCEPTIONS = [IsoCountryCodes::UnknownCodeError, IndexError]
  DEFAULT_ERROR_STORE = ->(row, reason) { @errors ||= []; @errors << [row, reason] }

  def initialize(options={})
    @error_store = options.fetch(:error_store) { DEFAULT_ERROR_STORE }
  end

  def with_errors_handling(row)
    begin
      yield
    rescue *HANDLING_EXCEPTIONS => exception
      @error_store.call(row, exception.to_s)
    end
  end
end
