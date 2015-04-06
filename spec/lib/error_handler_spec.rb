require "spec_helper"
require "cascade/error_handler"

describe Cascade::ErrorHandler do
  def described_class
    Cascade::ErrorHandler
  end

  let(:error_store) do
    ->(row, reason) do
      @errors ||= []
      @errors << [row, reason]
    end
  end
  let(:row) { Struct.new(:fields) }

  subject { described_class.new(error_store: error_store) }

  Cascade::ErrorHandler::HANDLING_EXCEPTIONS.each do |exception|
    it "catch #{exception} and send info to error store" do
      subject.with_errors_handling(row) { raise exception }
      assert_includes @errors, [row, exception.to_s]
    end
  end

  describe "DEFAULT_ERROR_STORE" do
    it "create new array and push row with reason" do
      result = Cascade::ErrorHandler::DEFAULT_ERROR_STORE.call(:row, :reason)
      assert_includes result, %i(row reason)
    end
  end
end
