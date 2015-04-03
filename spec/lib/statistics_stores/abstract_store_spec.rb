require_relative "../../spec_helper"
require_relative "../../../lib/cascade/statistics_stores/abstract_store"

describe StatisticsStores::AbstractStore do
  context "on initialization" do
    it "will rise NotImplementedError for default value" do
      assert_raises NotImplementedError do
        StatisticsStores::AbstractStore.new
      end
    end
  end

  it "return NotImplementedError for abstract method update" do
    assert_raises NotImplementedError do
      StatisticsStores::AbstractStore.new(1).update(:some_word)
    end
  end
end
