require_relative "../spec_helper"
require_relative "../../lib/cascade/row_processor"

describe Cascade::RowProcessor do
  def described_class
    Cascade::RowProcessor
  end

  it "allows to set settings" do
    assert_respond_to described_class, :use_default_presenter=
    assert_respond_to described_class, :deafult_presenter=
  end

  context "when parsing row" do
    let(:row) { [:a_value, :b_value, :c_value] }
    let(:keys) { [:a, :b, :c] }
    let(:columns_matching) { OpenStruct.new(supported_keys: keys) }

    before do
      keys.each_with_index  do |key, index|
        stub(columns_matching).index(key) { index }
        stub(columns_matching).column_type(key) { :string }
      end
    end

    it "collect row values with corresponding keys" do
      processed_row = described_class.new(columns_matching:
        columns_matching).call(row)
      assert_equal(processed_row, a: :a_value, b: :b_value, c: :c_value)
    end
  end

  context "when presenting row values" do
    let(:row) { ["raw_value"] }
    let(:columns_matching)  { OpenStruct.new(supported_keys: [:a]) }
    let(:value_presenter) { ->(_raw_value) { "parsed_value" } }

    before do
      stub(columns_matching).index(:a) { 0 }
      stub(columns_matching).column_type(:a) { :presenter }
    end

    context "when curresponding presenter passed" do
      it "process field with specified presenter" do
        parsed_value = described_class.new(columns_matching: columns_matching,
          presenter: value_presenter).call(row)[:a]
        assert_equal "parsed_value", parsed_value
      end
    end

    context "when curresponding presenter not passed" do
      it "process field with default presenter if use_default_presenter true" do
        described_class.stub(:use_default_presenter, true) do
          described_class.stub(:deafult_presenter, -> { value_presenter }) do
            parsed_value = described_class.new(columns_matching:
              columns_matching).call(row)[:a]
            assert_equal "parsed_value", parsed_value
          end
        end
      end

      it "process field and rise error if use_default_presenter false" do
        described_class.stub(:use_default_presenter, false) do
          assert_raises(Cascade::UnknownPresenterType) do
            described_class.new(columns_matching: columns_matching).call(row)
          end
        end
      end
    end
  end
end
