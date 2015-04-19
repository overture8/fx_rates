require "fx_rates/version"
require 'fx_rates/configuration'
require 'moneta'

module FxRates
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

      if store.key?(date)
        rates = store[date]
        base_rate = rates[from_country_code]
        counter_rate = rates[to_country_code]

        (counter_rate / base_rate) * 100
      end
    end
  end

  class << self
    attr_writer :configuration
  end

  # Provides singleton access to the Configuration instance.
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Allows some sugar for defining configuration using a block.
  def self.configure
    yield(configuration)
  end
end
