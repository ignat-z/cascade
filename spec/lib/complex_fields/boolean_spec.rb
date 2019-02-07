# frozen_string_literal: true

require 'spec_helper'
require 'cascade/complex_fields/boolean'

describe Cascade::ComplexFields::Boolean do
  def described_class
    Cascade::ComplexFields::Boolean
  end

  let(:subject) { described_class.new }

  it 'return true value for values that seems like true' do
    ['True', 'true', 'x', '+', true].each do |value|
      assert subject.call(value)
    end
  end

  it 'return false value for values that cant be true' do
    ['false', false, nil, '', 'some value'].each do |value|
      refute subject.call(value)
    end
  end
end
