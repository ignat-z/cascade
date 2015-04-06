module Cascade
  module ComplexFields
    class Boolean
      TRUE_VALUES = ["True", "true", "x", "+", true]

      def call(value)
        TRUE_VALUES.include?(value)
      end
    end
  end
end
