require_relative "../../spec_helper"
require_relative "../../../lib/cascade/helpers/hash"

describe Hash do
  describe "#reverse_merge" do
    let(:another_hash) { { a: 1, b: 2 } }
    let(:hash) { { a: 4, c: 3 } }

    it "merge self into anothe hash" do
      assert_equal hash.reverse_merge(another_hash),
        a: 4, b: 2, c: 3
    end
  end
end
