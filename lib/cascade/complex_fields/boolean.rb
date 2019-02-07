# frozen_string_literal: true

module Cascade
  module ComplexFields
    class Boolean
      TRUE_VALUES = ['True', 'true', 'x', '+', true].freeze

      def call(value)
        TRUE_VALUES.include?(value)
      end
    end
  end
end
