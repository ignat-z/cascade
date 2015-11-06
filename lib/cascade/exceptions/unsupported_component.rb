module Cascade
  class UnsupportedComponent < ::StandardError
    MESSAGE = "You should provide data provider that respond to `each` method"

    def initialize(msg = MESSAGE)
      super
    end
  end
end
