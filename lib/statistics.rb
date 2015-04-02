require "singleton"
require_relative "statistics_stores"

class Statistics
  include Singleton

  STORES = {
    counter: StatisticsStores::CounterStore,
    array: StatisticsStores::ArrayStore
  }.freeze

  def initialize
    @store_repository = {}
  end

  # Register statistics action with passed store
  #
  # @param action [Symbol] action name that will be used to access it
  # @param store [Symbol] type of using store
  # @param default_value [Object] value that will be used as default for store
  # @return [Object] instance of passed store
  def register_action(action, store, default_value = nil)
    @store_repository[action] = defined_stores.fetch(store.to_sym) do
      default_store
    end.new(default_value)
  end

  # Updates store action with passed value
  #
  # @param action [Symbol] action name that will be used to access it
  # @param value [Object] for updating store
  def update(action, value = nil)
    @store_repository[action].update(value)
  end

  # Returns statistics from store for passed action
  #
  # @param action [Symbol] action name that will be used to access it
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
