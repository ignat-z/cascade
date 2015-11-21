require "spec_helper"
require "cascade/helpers/hash"

describe Hash do
  describe "#reverse_merge" do
    using HashRefinements

    let(:another_hash) { { a: 1, b: 2 } }
    let(:example_hash) { { a: 4, c: 3 } }

    it "merge self into anothe hash" do
      assert_equal example_hash.reverse_merge(another_hash),
        a: 4, b: 2, c: 3
    end
  end
end
