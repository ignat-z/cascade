require 'active_record'
require 'yaml'
require 'logger'
require 'pg'

ActiveRecord::Base.establish_connection(YAML::load(File.open("config/database.yml")))

require_relative '../../models/company.rb'
