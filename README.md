# [Cascade]

[![Build Status](https://travis-ci.com/ignat-z/cascade.svg?branch=master)](https://travis-ci.com/ignat-z/cascade) [![Gem Version](https://badge.fury.io/rb/cascade-rb.svg)](http://badge.fury.io/rb/cascade-rb)

The main goal of this gem is to provide some kind of template for parsing files.
Usually, file parsing process consists of the following steps:

 1. Retrieve info from file
 2. Distinguish content from each file line
 3. Parse each column with corresponding parser
 4. Generate some kind of data record
 5. Save obtained record
 6. Handle errors
 7. Generate report

Cascade pretends to simplify main part of this step to save your time.

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

Provide enumerable object for parsing and run it!
```ruby
Cascade::DataParser.new(data_provider: Csv.open("data_test.csv")).call
```

## Columns mapping
Parsing file description should have the following structure [(example)](https://github.com/ignat-zakrevsky/cascade-example/blob/master/columns_mapping.yml)
```yaml
mapping:
  name: type
```

## Columns parsing
There are already several defined field parsers (types):

- currency
- boolean
- string

Feel free to add new field parsers through PR.

## Components replaceability
There is a lot of DI in this gem, so, you can replace each component of the parser. Let's assume you want to parse JSON files instead of CSV, save this to ActiveRecord model, and you need Date fields parsing, ok!
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
Writing date parser:
```ruby
class DateParser
  def call(value)
    Date.parse(value)
  end
end
```
or you can always use lambdas for such logic
```ruby
DATE_PARSER = -> (value) { Date.parse(value) }
```
Provide all this stuff into data parser
```ruby
Cascade::DataParser.new(
  data_provider: ParserJSON.new.open("data_test.csv"),
  row_processor: Cascade::RowProcessor.new(ext_parsers: { date: DateParser.new }),
  data_saver: PERSON_SAVER
 ).call
```
And that's all!
