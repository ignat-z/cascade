require_relative "../../spec_helper"
require_relative "../../../lib/concerns/statistics_collectible.rb"

describe StatisticsCollectible do
  class ExtendableClass; include StatisticsCollectible; end
  subject { ExtendableClass.new }

  it "defines helper for access to statics class" do
    assert_instance_of Statistics, subject.statistics
  end

  it "delegates register_action method to statistics" do
    assert_respond_to subject, :register_action
  end
end
