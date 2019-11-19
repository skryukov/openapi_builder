[gem]: https://rubygems.org/gems/openapi_builder
[codeclimate]: https://codeclimate.com/github/medsolutions/openapi_builder
[actions]: https://github.com/medsolutions/openapi_builder/actions

# openapi_builder
[![Gem Version](https://badge.fury.io/rb/openapi_builder.svg)][gem]
[![CI Status](https://github.com/medsolutions/openapi_builder/workflows/ruby/badge.svg)][actions]
[![Code Climate](https://codeclimate.com/github/medsolutions/openapi_builder/badges/gpa.svg)][codeclimate]
[![Test Coverage](https://codeclimate.com/github/medsolutions/openapi_builder/badges/coverage.svg)][codeclimate]
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)


Simple OpenAPI specification builder inspired by [Redoc.ly's Generator](https://github.com/ReDoc-ly/create-openapi-repo)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openapi_builder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openapi_builder

## Specification structure

This gem builds specification splitted into separate files by the specific rules.

Example folder structure:
```
openapi_spec
|-- openapi.yml
|-- paths
|   |-- customers.yml
|   |-- customers@{uuid}.yml
|-- components
|   |-- parameters
|   |   |-- Uuid.yml
|   |-- schemas
|   |   |-- Customer.yml
|   |-- requestBodies
|   |   |-- CreateCustomer.yml
|   |-- responses
|   |   |-- 404.yml
|   |   |-- 500.yml
```

### Root OpenAPI file

Create root file (i.e. `./openapi.yml`) with the basic information: `info`, `tags`, `servers`, etc.

### Paths

Put all paths into a separate directory `./paths/` and write each path specification in separate file. 

Filename is mapped to path by replacing `@` with `/`, i.e. `customers@{id}.yml` matches to `customers/{id}` path.

### Reusable components

Put all reusable components into `./components/` directory and then create necessary directories from the following list:
  - `schemas` - reusable [Schema Objects](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#schemaObject)
  - `responses` - reusable [Response Objects](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#responseObject)
  - `parameters` - reusable [Parameter Objects](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#parameterObject)
  - `examples` - reusable [Example Objects](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#exampleObject)
  - `headers` - reusable [Header Objects](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#headerObject)
  - `requestBodies` - reusable [Request Body Objects](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#requestBodyObject)
  - `links` - reusable [Link Objects](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#linkObject)
  - `callbacks` - reusable [Callback Objects](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#callbackObject)
  - `securitySchemes` - reusable [Security Scheme Objects](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#securitySchemeObject)

Filename of files inside the folders represent a component name, i.e. `Customer.yml`

### Usage

### cli

To build OpenAPI file run `openapi_builder build SRC_FILE DST_FILE`:

    $  openapi_builder build ./source/openapi.yml ./openapi.json

### ruby

You can build OpenAPI directly in your code:

```ruby
  OpenapiBuilder.call('./source/openapi.yml').data # => Hash
```

## Examples of repositories with splitted specification
- https://github.com/Rebilly/RebillyAPI
- https://github.com/thingful/openapi-spec
- https://github.com/TwineHealth/TwineDeveloperDocs

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/medsolutions/openapi_builder.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
