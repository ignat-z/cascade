# frozen_string_literal: true

module Cascade
  module ComplexFields
    class ArrayProcessor
      def initialize(processor)
        @processor = processor
      end

      def call(values)
        values.map { |value| @processor.call(value) }
      end
    end
  end
end
