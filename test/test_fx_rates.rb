$:.unshift File.dirname(__FILE__)
require 'test_helper'
require "fx_rates/api/consumer"
require "fx_rates/api/parser/mock"
include FxRates

class TestFxRates < Minitest::Test
  def setup
    FxRates.configure do |config|
      config.parser = Api::Parser::Mock
      config.store = Moneta.new(:LRUHash)
    end

    Api::Consumer.new
  end

  def test_correct_rate_calculated
    date = Date.parse("2015-01-01")
    assert_equal ExchangeRate.at(date, 'USD', 'JPY'), 118.78120954318476
  end

  def test_exception_is_raised_when_no_date
    date = Date.parse("2020-01-01")
    assert_raises(NoDateFoundError) { ExchangeRate.at(date, 'USD', 'JPY') }
  end

  def test_exception_is_raised_when_no_base_currency
    date = Date.parse("2015-01-01")
    invalid_base_code = '123'
    assert_raises(NoCurrencyCodeFoundError) { 
      ExchangeRate.at(date, invalid_base_code, 'JPY') 
    }
  end

  def test_exception_is_raised_when_no_base_currency
    date = Date.parse("2015-01-01")
    invalid_counter_code = '123'
    assert_raises(NoCurrencyCodeFoundError) { 
      ExchangeRate.at(date, 'JPY', invalid_counter_code) 
    }
  end


  def test_exception_is_raised_when_rate_invalid_type
    date = Date.parse("2015-01-01")
    assert_raises(RateInvalidTypeError) { 
      ExchangeRate.at(date, 'GBP', 'USD') # GBP is an invlid type.
    }
  end
end
