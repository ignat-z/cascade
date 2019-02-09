# frozen_string_literal: true

require 'cascade/version'
require 'cascade/columns_matching'
require 'cascade/row_processor'
require 'cascade/concerns/statistics_collectible'

# Base gem module
module Cascade
  autoload :DataParser, 'cascade/data_parser'
end
