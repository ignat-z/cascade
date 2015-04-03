require_relative "../statistics"

module Cascade
  module StatisticsCollectible
    module InstanceMethods
      def statistics
        @statistics ||= Statistics.instance
      end
    end

    def self.included(receiver)
      receiver.extend Forwardable
      receiver.send :include, InstanceMethods
      receiver.def_delegator :statistics, :register_action
    end
  end
end
