require "singleton"
require_relative './statistics_stores/abstract_store'
require_relative './statistics_stores/counter_store'
require_relative './statistics_stores/array_store'

class Statistics
  include Singleton

  STORES = {
    counter: StatisticsStores::CounterStore,
    array: StatisticsStores::ArrayStore
  }.freeze

  def initialize
    @store_repository = {}
  end

  def register_action(action, store, default_value=nil)
    @store_repository[action] = defined_stores.fetch(store.to_sym) do
      default_store
    end.new(default_value)
  end

  def update(action, value = nil)
    @store_repository[action].update(value)
  end

  def for(action)
    @store_repository[action].store
  end

  protected
  attr_reader :store_repository

  private

  def defined_stores
    STORES
  end

  def default_store
    StatisticsStores::AbstractStore
  end
end
