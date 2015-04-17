require 'test_helper'

class TestFxRates < Minitest::Test
  def test_correct_rate_calculated
    assert_equal ::FxRates::ExchangeRate.at('20150414', 'GBP', 'USD'), 149.82751426
  end
end
