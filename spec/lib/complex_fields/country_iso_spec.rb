require_relative '../../spec_helper'
require_relative '../../../lib/complex_fields/country_iso'

describe ComplexFields::CountryIso do
  let(:subject) { ComplexFields::CountryIso.new }

  it 'translate country name to alpha-2 code' do
    assert_equal subject.call("France"), 'FR'
  end

  it 'raise error if there is no such country' do
    assert_raises IsoCountryCodes::UnknownCodeError do
      subject.call("some_blank_value")
    end
  end
end
