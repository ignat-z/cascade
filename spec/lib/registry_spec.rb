# frozen_string_literal: true

require 'spec_helper'
require 'cascade/registry'

describe Cascade::Registry do
  def described_class
    Cascade::Registry
  end

  it 'return default callable row processor' do
    assert_respond_to described_class.row_processor, :call
  end

  it 'creates new instance of default error handler' do
    mock(Cascade::ErrorHandler).new
    described_class.error_handler
  end

  it 'return default callable data saver' do
    assert_respond_to described_class.data_saver, :call
  end

  it 'return default data provider' do
    assert_raises(Cascade::UnsupportedComponent) do
      described_class.data_provider
    end
  end
end
