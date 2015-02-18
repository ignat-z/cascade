require_relative '../lib/cascade_csv'
require_relative '../lib/companies_parser'

desc "Parse file with companies."
task :parse, [] do |_, args|
  CompaniesParser.new('spec/examples/companies_test.txt').call
end
