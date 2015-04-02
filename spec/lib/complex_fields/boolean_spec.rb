require_relative '../../spec_helper'
require_relative '../../../lib/complex_fields/boolean'

describe ComplexFields::Boolean do
  let(:subject) { ComplexFields::Boolean.new }

  it "return true value for values that seems like true" do
    ["True",  "true",  "x",  "+",  true].each do |value|
      assert subject.call(value)
    end
  end

  it "return false value for values that cant be true" do
    ["false", false, nil, "", "some value"].each do |value|
      refute subject.call(value)
    end
  end
end
