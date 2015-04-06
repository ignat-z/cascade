require "spec_helper"
require "cascade/columns_matching"

describe Cascade::ColumnsMatching do
  def described_class
    Cascade::ColumnsMatching
  end
  subject { described_class.new }

  context "on settings file parsing" do
    subject { described_class.new(filepath: "config/columns_match.yml") }

    it "raise error if columns matching file doesnt contain mapping key" do
      mock(YAML).load_file("config/columns_match.yml") { {} }
      assert_raises(Cascade::WrongMappingFormat) { subject }
    end

    it "raise error if columns matching file doesnt contain any info" do
      mock(YAML).load_file("config/columns_match.yml") { nil }
      assert_raises(Cascade::WrongMappingFormat) { subject }
    end
  end

  context "after file parsed" do
    before do
      stub(YAML).load_file do
        {
          "mapping" => {
            "name"  => "string",
            "class" => "string"
          }
        }
      end
    end

    context "#supported_keys" do
      it { subject.must_respond_to(:supported_keys) }
      it "return array" do
        subject.supported_keys.must_be_kind_of Array
      end
    end

    context "#column_type" do
      it "return curresponding value for passed column value" do
        assert_equal :string,
          described_class.new(content: { name: "string" }).column_type(:name)
      end
    end
  end

  it { delegate_method(:index).to(:supported_keys) }
end
