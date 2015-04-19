require 'test_helper'
require "api/consumer"
require "api/parser/mock"
include FxRates

class TestApiConsumer < Minitest::Test
  def setup
    FxRates.configure do |config|
      config.parser = Api::Parser::Mock
      config.store = Moneta.new(:LRUHash)
    end

    Api::Consumer.new
  end

  def test_storage_and_retrieval_of_api_data
    store = ::FxRates.configuration.store
    date = Date.parse("2015-01-01")
    assert_equal store[date]["USD"], 1.0814
  end
end
