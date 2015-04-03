require_relative "../../spec_helper"
require_relative "../../../lib/cascade/complex_fields/currency"

describe ComplexFields::Currency do
  subject { ComplexFields::Currency.new }

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
