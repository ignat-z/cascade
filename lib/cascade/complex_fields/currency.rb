# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'

module Cascade
  module ComplexFields
    class Currency
      def call(value)
        value = normalized_value(value)
        value.to_d if valid?(value)
      end

      private

      def normalized_value(value)
        String(value).tr(',', '.').tr(' ', '')
      end

      def valid?(value)
        true if Float(value)
      rescue StandardError
        false
      end
    end
  end
end
