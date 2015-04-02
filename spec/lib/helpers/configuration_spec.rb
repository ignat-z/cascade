require_relative "../../spec_helper"
require_relative "../../../lib/helpers/configuration"

describe StatisticsCollectible do
  class ExtendableClass
    extend Configuration

    define_setting :simple_setting
    define_setting :setting_with_default, 42
  end

  it "defines class variables with curresponding default values" do
    assert_equal ExtendableClass.class_variables,
      [:@@simple_setting, :@@setting_with_default]
  end

  it "defines reader methods for extended class" do
    assert ExtendableClass.respond_to?(:simple_setting)
    assert ExtendableClass.respond_to?(:setting_with_default)
  end

  it "defines write accessor for extended class" do
    assert ExtendableClass.respond_to?(:simple_setting=)
    assert ExtendableClass.respond_to?(:setting_with_default=)
  end

  it "allows to set class variables in configuration block" do
    ExtendableClass.configuration do |config|
      config.simple_setting = :value
      config.setting_with_default = 29
    end

    assert_equal ExtendableClass.setting_with_default, 29
    assert_equal ExtendableClass.simple_setting, :value
  end
end
