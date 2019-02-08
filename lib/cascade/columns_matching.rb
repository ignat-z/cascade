# frozen_string_literal: true

require 'yaml'
require 'forwardable'
require 'cascade/exceptions'

module Cascade
  class ColumnsMatching
    extend Forwardable

    ROOT_KEY = 'mapping'

    def_delegator :supported_keys, :index

    def initialize(options = {})
      @content = options.fetch(:content) do
        parse_content_file(options.fetch(:filepath))
      end
    end

    # Defines set of possible keys that can be used for iterating through
    # the parsed line
    #
    # @return [Array] of the supported keys
    def supported_keys
      @supported_keys ||= @content.keys
    end

    # Presenter for passed key
    #
    # @return [Symbol] with the corresponding value
    def column_type(key)
      @content[key].to_sym
    end

    private

    def parse_content_file(filepath)
      content = YAML.load_file(filepath)
      (content && content[ROOT_KEY]) || raise(Cascade::WrongMappingFormat)
    end
  end
end
