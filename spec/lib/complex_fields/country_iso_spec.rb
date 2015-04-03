require_relative "../../spec_helper"
require_relative "../../../lib/cascade/complex_fields/country_iso"

describe Cascade::ComplexFields::CountryIso do
  def described_class
    Cascade::ComplexFields::CountryIso
  end

  let(:subject) { described_class.new }

  it "translate country name to alpha-2 code" do
    assert_equal subject.call("France"), "FR"
  end

  it "raise error if there is no such country" do
    assert_raises IsoCountryCodes::UnknownCodeError do
      subject.call("some_blank_value")
    end
  end

  it "return nil if nil value passed" do
    assert_nil subject.call(nil)
  end
end
