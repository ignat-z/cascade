# frozen_string_literal: true

require 'spec_helper'
require 'cascade/statistics_stores/abstract_store'
require 'cascade/statistics_stores/array_store'

describe Cascade::StatisticsStores::ArrayStore do
  subject { Cascade::StatisticsStores::ArrayStore.new }

  context 'on initialization' do
    it 'use empty array as default value' do
      assert_equal subject.store, []
    end
  end

  it 'add value to array on update' do
    mock(subject.store).<<(:some_value)
    subject.update(:some_value)
  end
end
