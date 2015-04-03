require_relative "../../spec_helper"
require_relative "../../../lib/cascade/concerns/statistics_collectible.rb"

describe Cascade::StatisticsCollectible do
  class ExtendableClass; include Cascade::StatisticsCollectible; end
  subject { ExtendableClass.new }

  it "defines helper for access to statics class" do
    assert_instance_of Cascade::Statistics, subject.statistics
  end

  it "delegates register_action method to statistics" do
    assert_respond_to subject, :register_action
  end
end
