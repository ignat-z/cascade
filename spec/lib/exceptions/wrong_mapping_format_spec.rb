# frozen_string_literal: true

require 'spec_helper'
require 'cascade/exceptions/wrong_mapping_format'

describe Cascade::WrongMappingFormat do
  subject { Cascade::WrongMappingFormat.new }
  it 'exception raisable' do
    assert_respond_to subject, :exception
  end
end
