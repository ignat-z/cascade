# frozen_string_literal: true

require 'spec_helper'
require 'cascade/columns_matching'

describe Cascade::ColumnsMatching do
  def described_class
    Cascade::ColumnsMatching
  end

  context 'on settings file parsing' do
    subject { described_class.new(filepath: 'config/columns_match.yml') }

    it "raise error if columns matching file doesn't contain mapping key" do
      mock(YAML).load_file('config/columns_match.yml') { {} }
      assert_raises(Cascade::WrongMappingFormat) { subject }
    end

    it "raise error if columns matching file doesn't contain any info" do
      mock(YAML).load_file('config/columns_match.yml') { nil }
      assert_raises(Cascade::WrongMappingFormat) { subject }
    end
  end

  context 'after file parsed' do
    subject { described_class.new(content: { name: 'string' }) }

    context '#supported_keys' do
      it { subject.must_respond_to(:supported_keys) }

      it 'return array' do
        subject.supported_keys.must_be_kind_of Array
      end
    end

    context '#column_type' do
      it 'return curresponding value for passed column value' do
        assert_equal :string, subject.column_type(:name)
      end
    end
  end

  it { delegate_method(:index).to(:supported_keys) }
end
