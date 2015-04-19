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
    assert_equal ExchangeRate.at(date, 'USD', 'JPY'), 11878.120954318476
  end
end
