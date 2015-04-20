# FxRates 

[![Build Status](https://travis-ci.org/overture8/fx_rates.svg?branch=master)](https://travis-ci.org/overture8/fx_rates)
[![Code Climate](https://codeclimate.com/github/overture8/fx_rates/badges/gpa.svg)](https://codeclimate.com/github/overture8/fx_rates)

FxRates is a Ruby library that allows you to convert from one currency to another
using exchange rates from a given service.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fx_rates', github: 'overture8/fx_rates'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fx_rates

## Usage

```ruby
require 'fx_rates'
ExchangeRate.at(Date.today, 'GBP', 'USD')
````

## Rake Task

Can be ran by cron job to cache API data to key/value store

    rake consume_api

## Configuration

```ruby
require 'fx_rates'

FxRates.configure do |config|
  config.parser = FxRates::Api::Parser::Ecb
  config.store = Moneta.new(:File, dir: 'db/moneta')
end
````

## Parsers

FxRates provides a way for different API parsers to be integrated. See the `lib/api/parser`
direct for examples of how to implement different strategies. Currently supported:-

* ECB - [European Central Bank](http://www.ecb.europa.eu/stats/eurofxref/eurofxref­hist­90d.xml)

## Stores

The [Moneta](https://github.com/minad/moneta) library is used for providing a unified
interface for key/value stores. This is to allow different key/value stores to be swapped
in and out when required. See the moneta docs for a list of the available stores.

## Tests

    bundle exec guard

## Contributing

1. Fork it ( https://github.com/[my-github-username]/fx_rates/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
