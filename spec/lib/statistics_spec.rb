require_relative '../spec_helper'
require_relative '../../lib/statistics'

describe Statistics do
  subject { Statistics.instance }

  context '#register_action' do
    it 'regsiter store for statistics with passed name, store type and value' do
      subject.register_action(:record_parsed, :counter)
      assert_instance_of StatisticsStores::CounterStore, subject
        .send(:store_repository)[:record_parsed]
    end

    it 'raise NotImplementedError for unknown stores' do
      assert_raises NotImplementedError do
        subject.register_action(:some_action, :magic)
      end
    end
  end

  context '#register_action' do
    it 'delegate update action to store with passed value' do
      mock(subject.send(:store_repository)[:record_parsed]).update(29)
      subject.update(:record_parsed, 29)
    end

    it 'delegate update action to store with nil as default value' do
      mock(subject.send(:store_repository)[:record_parsed]).update(nil)
      subject.update(:record_parsed, nil)
    end
  end

  context '#for' do
    it 'retrives info from store object' do
      mock(subject.send(:store_repository)[:record_parsed]).store
      subject.for(:record_parsed)
    end
  end
end
