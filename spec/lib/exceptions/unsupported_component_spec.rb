# frozen_string_literal: true

require 'spec_helper'
require 'cascade/exceptions/unsupported_component'

describe Cascade::UnsupportedComponent do
  subject { Cascade::UnsupportedComponent.new }
  it 'exception raisable' do
    assert_respond_to subject, :exception
  end

  context '#message' do
    it 'uses passed message' do
      subject = Cascade::UnsupportedComponent.new('custom_message')
      assert_equal subject.message, 'custom_message'
    end

    it 'uses default message if not passed' do
      assert_equal subject.message, Cascade::UnsupportedComponent::MESSAGE
    end
  end
end
