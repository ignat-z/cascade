require 'yaml'
require_relative "exceptions"

class ColumnsMatching
  extend Forwardable

  def_delegator :supported_keys, :index

  def initialize(options = {})
    @filepath = options[:filepath]
    @content = options.fetch(:content) { parse_content_file }
  end

  # Defines set of possible keys that can be used for iterating through
  # parsed line
  #
  # @return [Array] of supported keys
  def supported_keys
    @supported_keys ||= @content.keys
  end

  # Presenter for passed key
  #
  # @return [Symbol] with curresponding value
  def column_type(key)
    @content[key].to_sym
  end

  private

  def parse_content_file
    content = YAML.load_file(@filepath)
    (content && content["mapping"]) || raise(Cascade::WrongMappingFormat.new)
  end
end