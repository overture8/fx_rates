require 'test_helper'
require "api/consumer"
require "api/parser/mock"

class TestFxRates < Minitest::Test
  def setup
    ::FxRates.configure do |config|
      config.parser = Api::Parser::Mock
      config.store = Moneta.new(:LRUHash)
    end

    Api::Consumer.new
  end

  def test_correct_rate_calculated
    assert_equal ::FxRates::ExchangeRate.at('2015-01-01', 'USD', 'JPY'), 11878.120954318476
  end
end
