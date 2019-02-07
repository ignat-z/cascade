# frozen_string_literal: true

module Configuration
  def configuration
    yield self
  end

  def define_setting(name, default = nil)
    class_variable_set("@@#{name}", default)

    define_cattr_reader(name)
    define_cattr_writer(name)
  end

  private

  def define_cattr_reader(name)
    define_class_method name do
      class_variable_get("@@#{name}")
    end
  end

  def define_cattr_writer(name)
    define_class_method "#{name}=" do |value|
      class_variable_set("@@#{name}", value)
    end
  end

  def define_class_method(name, &block)
    (class << self; self; end).instance_eval do
      define_method name, &block
    end
  end
end
