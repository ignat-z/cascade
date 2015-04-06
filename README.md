# [Cascade]

[![Codeship Status for ignat-zakrevsky/cascade](https://codeship.com/projects/d7590880-9943-0132-4aa6-1e41bc68e178/status?branch=master)](https://codeship.com/projects/63625) [![Code Climate](https://codeclimate.com/github/ignat-zakrevsky/cascade/badges/gpa.svg)](https://codeclimate.com/github/ignat-zakrevsky/cascade) [![Test Coverage](https://codeclimate.com/github/ignat-zakrevsky/cascade/badges/coverage.svg)](https://codeclimate.com/github/ignat-zakrevsky/cascade) [![Gem Version](https://badge.fury.io/rb/cascade-rb.svg)](http://badge.fury.io/rb/cascade-rb)

The main aim of this gem is to provide some kind of template for parsing files.
Usually, parsing file process contains next steps:

 1. Retreiving info from file
 2. Distinguish content from each file line
 3. Parse each column with corresponding parser
 4. Generate some kind of data record
 5. Save obtained record
 6. Handle errors
 7. Generate report

Cascade pretends to simplify main part of this step to save your time.

## Example 

[Working Example](https://github.com/ignat-zakrevsky/cascade-example)

## Installation
Install the cascade-rb package from Rubygems:
```
gem install cascade-rb
```

or add it to your Gemfile for Bundler:
```ruby
gem 'cascade-rb'
```

## Usage
Require gem files 
```ruby
require 'cascade'
```

Configure it!
```ruby
Cascade.configuration do
  Cascade::RowProcessor.use_default_presenter = false # will throw exception in case of unavailable presenter
  Cascade::ColumnsMatching.mapping_file = "columns_mapping.yml" # file with columns mapping, see below 
end
```

Provide file for parsing and run it!
```ruby
Cascade::DataParser.new("data_test.txt").call
```

## Columns mapping
Parsing file description should have next structure [(example)](https://github.com/ignat-zakrevsky/cascade-example/blob/master/columns_mapping.yml)
```yaml
mapping: 
  name: type
```

## Components replaceability
There is a lot of DI in this gem, so, you can replace each component of the parser. Let's assume you want to parse JSON files instead of CSV and save this to ActiveRecord model, ok!
Writing new data provider:
```ruby
class ParserJSON
  def open(file)
    JSON.parse(File.read(file))["rows"]
  end
end
```
Writing new data saver:
```ruby
class PersonDataSaver
  def call(person_data)
    Person.create!(person_data)
  end
end
```
considering that there is no much logic even better
```ruby
 PERSON_SAVER = -> (person_data) { Person.create!(person_data) }
```
Provide it for data providing for data parser
```ruby
Cascade::DataParser.new("data_test.json", data_saver: PERSON_SAVER,
  data_provider: ParserJSON.new).call
```
And that's all!
[Example](https://github.com/ignat-zakrevsky/cascade-example/blob/json-example/main.rb)
## Conventions
I'm fan of callable object as consequence I prefer #call methods for classes with one responsibility. [Nice video](http://www.rubytapas.com/episodes/35-Callable) that describes benefits of such approach
