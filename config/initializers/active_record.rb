require "active_record"
require "yaml"
require "logger"
require "pg"

ActiveRecord::Base.establish_connection(
  YAML::load(File.open("config/database.yml")))

Dir[File.dirname(__FILE__) + "/models/*.rb"].each(&method(:require))
