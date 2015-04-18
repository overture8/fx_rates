require 'test_helper'
require "api/parser/mock"
require 'moneta'

class TestConfiguration < Minitest::Test
  def setup
    @store = Moneta.new(:LRUHash)

    ::FxRates.configure do |config|
      config.parser = Api::Parser::Mock
      config.store = @store
    end
  end

  def test_returns_api_with_correct_data
    assert_equal ::FxRates.configuration.parser, Api::Parser::Mock
    assert_equal ::FxRates.configuration.store, @store
  end
end
