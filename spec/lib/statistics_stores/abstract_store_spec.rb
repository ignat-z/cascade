# frozen_string_literal: true

require 'spec_helper'
require 'cascade/statistics_stores/abstract_store'

describe Cascade::StatisticsStores::AbstractStore do
  def described_class
    Cascade::StatisticsStores::AbstractStore
  end

  context 'on initialization' do
    it 'will rise NotImplementedError for default value' do
      assert_raises NotImplementedError do
        described_class.new
      end
    end
  end

  it 'return NotImplementedError for abstract method update' do
    assert_raises NotImplementedError do
      described_class.new(1).update(:some_word)
    end
  end
end
