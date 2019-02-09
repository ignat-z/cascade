# frozen_string_literal: true

require 'cascade/statistics'

module Cascade
  module StatisticsCollectible
    module InstanceMethods
      def statistics
        @statistics ||= Statistics.new
      end
    end

    def self.included(receiver)
      receiver.send :include, InstanceMethods
    end
  end
end
