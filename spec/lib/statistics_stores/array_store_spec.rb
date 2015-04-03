require_relative "../../spec_helper"
require_relative "../../../lib/cascade/statistics_stores/abstract_store"
require_relative "../../../lib/cascade/statistics_stores/array_store"

describe StatisticsStores::ArrayStore do
  subject { StatisticsStores::ArrayStore.new }

  context "on initialization" do
    it "use empty array as default value" do
      assert_equal subject.store, []
    end
  end

  it "add value to array on update" do
    mock(subject.store).<<(:some_value)
    subject.update(:some_value)
  end
end
