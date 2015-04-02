require_relative "../spec_helper"
require_relative "../../lib/error_handler"

describe ErrorHandler do
  let(:error_store) do
    ->(row, reason) do
      @errors ||= []
      @errors << [row, reason]
    end
  end
  let(:row) { Struct.new(:fields) }

  subject { ErrorHandler.new(error_store: error_store) }

  ErrorHandler::HANDLING_EXCEPTIONS.each do |exception|
    it "catch #{exception} and send info to error store" do
      subject.with_errors_handling(row) { raise exception }
      assert_includes @errors, [row, exception.to_s]
    end
  end
end
