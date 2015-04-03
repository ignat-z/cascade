require "iso_country_codes"

module ComplexFields
  class CountryIso
    def call(country)
      return unless country
      IsoCountryCodes.search_by_name(country).first.alpha2
    end
  end
end
