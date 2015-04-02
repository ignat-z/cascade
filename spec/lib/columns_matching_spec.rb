require_relative "../spec_helper"
require_relative "../../lib/columns_matching"

describe ColumnsMatching do
  subject { ColumnsMatching.new }

  context "#supported_keys" do
    it { subject.must_respond_to(:supported_keys) }
    it "return array" do
      subject.supported_keys.must_be_kind_of Array
    end
  end

  context "#column_type" do
    it "return curresponding value for passed column value" do
      assert_equal :string,
        ColumnsMatching.new(content: { name: "string" }).column_type(:name)
    end
  end

  it "raise error if columns matching file doesnt contain mapping key" do
    mock(YAML).load_file("config/columns_match.yml") { {} }
    assert_raises(Cascade::WrongMappingFormat) { subject }
  end

  it "raise error if columns matching file doesnt contain any info" do
    mock(YAML).load_file("config/columns_match.yml") { nil }
    assert_raises(Cascade::WrongMappingFormat) { subject }
  end

  it { delegate_method(:index).to(:supported_keys) }
end
