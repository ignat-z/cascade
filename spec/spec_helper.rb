# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'
  add_filter 'vendor/'
end

require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/mock'
require 'minitest/hell'
require 'shoulda/matchers'
require 'rr'

module Minitest
  class Test
    parallelize_me!
  end
end

module Kernel
  alias context describe
end
