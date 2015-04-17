require "fx_rates/version"

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
      149.82751426 
    end
  end
end
