require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'
  add_filter 'vendor/'
end

require_relative '../config/initializers/active_record'

require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/mock'

require 'awesome_print'
require 'pry'
require 'rr'

alias :context :describe

