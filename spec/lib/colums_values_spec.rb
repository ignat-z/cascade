require_relative '../spec_helper'
require_relative '../../lib/columns_values'

describe ColumnsValues do
  subject { ColumnsValues.new }

  context "#supported_keys" do
    it { subject.must_respond_to(:supported_keys) }
    it "return array" do
      subject.supported_keys.must_be_kind_of Array
    end
  end


  context "respond to single values columns" do
    ColumnsValues::SUPPORTED_KEYS.each do |key|
      it { subject.must_respond_to(key) }
    end
  end
end
