require_relative '../spec_helper'
require_relative '../../lib/columns_values'

describe ColumnsValues do
  let(:subject) { ColumnsValues.new }

  context "#supported_keys" do
    it { subject.must_respond_to(:supported_keys) }
    it "return array" do
      subject.supported_keys.must_be_kind_of Array
    end
  end

  context "respond to single values columns" do
    it { subject.must_respond_to( :year_founded) }
    it { subject.must_respond_to( :bvd_id) }
    it { subject.must_respond_to( :revenue_usd) }
    it { subject.must_respond_to( :ebitda_usd) }
    it { subject.must_respond_to( :employees) }
    it { subject.must_respond_to( :total_assets) }
    it { subject.must_respond_to( :description) }
    it { subject.must_respond_to( :major_sector) }
    it { subject.must_respond_to( :name) }
    it { subject.must_respond_to( :year_founded) }
  end

  context "respond to multiple values columns" do
    it { subject.must_respond_to(:revenue_usd) }
    it { subject.must_respond_to(:ebitda_usd) }
    it { subject.must_respond_to(:employees) }
    it { subject.must_respond_to(:total_assets) }
  end
end
