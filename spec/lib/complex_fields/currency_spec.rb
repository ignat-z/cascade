require "spec_helper"
require "cascade/complex_fields/currency"

describe Cascade::ComplexFields::Currency do
  def described_class
    Cascade::ComplexFields::Currency
  end

  subject { described_class.new }

  describe "parse" do
    it "return nil if input string isn't number" do
      assert_nil subject.call("0o")
    end

    it "prepare string to use it as bignum" do
      assert_kind_of BigDecimal, subject.call("1 123 123 45")
      assert_kind_of BigDecimal, subject.call("1 123, 123 45")
    end

    it "return zero if field is empty" do
      assert_nil subject.call("")
      assert_nil subject.call(nil)
    end
  end
end
