require "cascade/version"
require "cascade/columns_matching"
require "cascade/row_processor"
require "cascade/error_handler"
require "cascade/helpers/configuration"

# Base gem module
module Cascade
  extend Configuration

  autoload :DataParser, "cascade/data_parser"
end
