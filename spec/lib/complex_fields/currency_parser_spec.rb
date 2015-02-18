require_relative '../../spec_helper'
require_relative '../../../lib/complex_fields/currency_parser'

describe ComplexFields::CountryIso do

  subject { ComplexFields::CurrencyParser.new }

  describe 'parse' do
    it "validates input string to be shure that it's number and return nil if it's not" do
      assert_nil subject.call('0o')
    end

    it "prepare string to use it as bignum" do

      assert_kind_of BigDecimal, subject.call('1 123 123 45')
      assert_kind_of BigDecimal, subject.call('1 123, 123 45')
    end

    it "return zero if field is empty" do
      assert_nil subject.call('')
      assert_nil subject.call(nil)
    end
  end

end
