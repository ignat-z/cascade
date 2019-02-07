# frozen_string_literal: true

module Cascade
  module StatisticsStores
    class CounterStore < AbstractStore
      def update(value = nil)
        value ||= 1
        @store += value
      end

      private

      def initialize_value
        0
      end
    end
  end
end
