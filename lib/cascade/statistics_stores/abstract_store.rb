module Cascade
  module StatisticsStores
    class AbstractStore
      def initialize(default_value = nil)
        @store = default_value || initialize_value
      end

      attr_reader :store

      def update(*)
        raise NotImplementedError
      end

      private

      def initialize_value(*)
        raise NotImplementedError
      end
    end
  end
end
