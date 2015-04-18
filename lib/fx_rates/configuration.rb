require "api/parser/mock"
require "moneta"

module FxRates
  class Configuration
    attr_accessor :parser, :store

    def initialize
      # Defaults
      @parser = Api::Parser::Mock
      @store = Moneta.new(:LRUHash)
    end
  end
end
