require "fx_rates/api/parser/mock"
require "moneta"

module FxRates
  # Configuration provides library wide configuration
  # to be defined and retrieved.
  #
  # parser - The parser strategy that you wish to use.
  # store - The key/value store that you wish to use.
  class Configuration
    attr_accessor :parser, :store

    def initialize
      # Defaults
      @parser = Api::Parser::Mock
      @store = Moneta.new(:LRUHash)
    end
  end
end
