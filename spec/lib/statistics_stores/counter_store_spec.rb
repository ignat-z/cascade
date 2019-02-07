# frozen_string_literal: true

require 'spec_helper'
require 'cascade/statistics_stores/abstract_store'
require 'cascade/statistics_stores/counter_store'

describe Cascade::StatisticsStores::CounterStore do
  subject { Cascade::StatisticsStores::CounterStore.new }

  context 'on initialization' do
    it 'use empty array as default value' do
      assert_equal subject.store, 0
    end
  end

  it 'add value to array on update' do
    previous_value = subject.store
    subject.update
    assert_equal subject.store, previous_value + 1
  end
end
