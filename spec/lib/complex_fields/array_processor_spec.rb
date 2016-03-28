require "spec_helper"
require "cascade/complex_fields/array_processor"

describe Cascade::ComplexFields::ArrayProcessor do
  def described_class
    Cascade::ComplexFields::ArrayProcessor
  end

  let(:processor) { -> (value) { value + 1 } }
  let(:subject) { described_class.new(processor) }

  it "return processed array" do
    assert_equal subject.call([1, 2, 3]), [2, 3, 4]
  end
end
