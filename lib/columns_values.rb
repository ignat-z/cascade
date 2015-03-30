class ColumnsValues
  extend Forwardable

  def_delegator :supported_keys, :index

  def initialize(options = {})
    @content = options.fetch(:content) { parse_content_file }
  end

  # Defines set of possible keys that can be used for iterating through
  # parsed line
  #
  # @return [Array] of supported keys
  def supported_keys
    @supported_keys ||= @content.fetch('mapping')
  end

  private

  def parse_content_file
    YAML.load_file('config/columns_match.yml')
  end
end
