# frozen_string_literal: true

require 'spec_helper'
require 'cascade/error_handler'

describe Cascade::ErrorHandler do
  def described_class
    Cascade::ErrorHandler
  end

  let(:error_store) do
    lambda do |row, reason|
      @errors ||= []
      @errors << [row, reason.to_s]
    end
  end
  let(:row) { Struct.new(:fields) }

  context 'when raise_parse_errors setting is false' do
    subject { described_class.new(error_store: error_store) }

    it 'catches handling exceptions and send info to error store' do
      subject.with_errors_handling(row) { raise IndexError }
      assert_includes @errors, [row, IndexError.to_s]
    end
  end

  context 'when raise_parse_errors setting is true' do
    subject do
      described_class.new(error_store: error_store, raise_parse_errors: true)
    end

    it 'raises for handling exceptions' do
      assert_raises(IndexError) do
        subject.with_errors_handling(row) { raise IndexError }
      end
    end
  end

  describe 'DEFAULT_ERROR_STORE' do
    it 'create new array and push row with reason' do
      result = Cascade::ErrorHandler::DEFAULT_ERROR_STORE.call(:row, :reason)
      assert_includes result, [:row, 'reason']
    end
  end
end
