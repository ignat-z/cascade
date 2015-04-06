# [Cascade]

[![Codeship Status for ignat-zakrevsky/cascade](https://codeship.com/projects/d7590880-9943-0132-4aa6-1e41bc68e178/status?branch=master)](https://codeship.com/projects/63625) [![Code Climate](https://codeclimate.com/github/ignat-zakrevsky/cascade/badges/gpa.svg)](https://codeclimate.com/github/ignat-zakrevsky/cascade) [![Test Coverage](https://codeclimate.com/github/ignat-zakrevsky/cascade/badges/coverage.svg)](https://codeclimate.com/github/ignat-zakrevsky/cascade) [![Gem Version](https://badge.fury.io/rb/cascade-rb.svg)](http://badge.fury.io/rb/cascade-rb)

The main aim of this repo is to provide some kind of template for parsers.
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
