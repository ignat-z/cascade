# frozen_string_literal: true

module Cascade
  module StatisticsStores
    class ArrayStore < AbstractStore
      def update(value)
        @store << value
      end

      private

      def initialize_value
        []
      end
    end
  end
end
