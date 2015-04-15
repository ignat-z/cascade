require "simplecov"
SimpleCov.start do
  add_filter "spec/"
  add_filter "vendor/"
end

require "minitest/autorun"
require "minitest/pride"
require "minitest/mock"
require "minitest/hell"
require "shoulda/matchers"
require "rr"

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

class Minitest::Test
  parallelize_me!
end

alias :context :describe
