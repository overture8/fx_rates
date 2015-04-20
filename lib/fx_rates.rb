require "fx_rates/version"
require 'fx_rates/configuration'
require 'fx_rates/api/parser/ecb'
require 'fx_rates/railtie' if defined?(Rails)
require 'moneta'

module FxRates
  # Exception to be raised if no date is found as the key in the
  # key/value store.
  class NoDateFoundError < StandardError; end

  # Exception to be raised if either the base or counter currency
  # code is not found.
  class NoCurrencyCodeFoundError < StandardError
    attr_reader :type
    def initialize(type)
      @type = type
    end
  end

  class ExchangeRate
    # Looks up the date from the key/value store then extract
    # the relevant base and counter rates to calculate the resulting
    # amount.
    #
    # date - The date for which the rates should be used. 
    # from_country_code - The country code for the from currency.
    # to_country_code - The country code for the to currency.
    #
    # Examples:
    #
    #   ExchangeRate.at(Date.today,'GBP','USD')
    #
    # Returns the calculated value in the require currency.
    def self.at(date, from_country_code, to_country_code)
      store = FxRates.configuration.store
      raise NoDateFoundError.new unless store.key?(date)

      rates = store[date]
      base_rate = rates[from_country_code]
      counter_rate = rates[to_country_code]
      raise NoCurrencyCodeFoundError.new(:base) if base_rate.nil?
      raise NoCurrencyCodeFoundError.new(:counter) if counter_rate.nil?

      (counter_rate / base_rate).round(2)
    end
  end

  # Interface for interacting with global configuation.
  class << self
    attr_writer :configuration

    # Provides singleton access to the Configuration instance.
    def configuration
      @configuration ||= Configuration.new
    end

    # Allows some sugar for defining configuration using a block.
    def configure
      yield(configuration)
    end
  end

end
