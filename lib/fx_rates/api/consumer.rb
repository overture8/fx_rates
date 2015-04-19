$:.unshift File.dirname(__FILE__)

module Api
  # The Consumer class is responsible for instanciating the
  # appropriate Parser strategy. It is affectively the 'context'
  # part of the strategy pattern.
  #
  # options - Any data data that needs to be passed through
  # to the strategies.
  #
  # Examples:
  #
  #   Api::Consumer.new
  #
  # Returns nothing.
  class Consumer
    attr_reader :options

    def initialize(options={})
      @options = options
      @options[:store] = ::FxRates.configuration.store
      @options[:parser] = ::FxRates.configuration.parser
      parse
      @options[:store].close
    end

    # This method should be implmented by each strategy. The strategy should
    # parse the relevant API response, format it in the standard format ( displayed
    # below) and store it to the key/value store.
    #
    # Example standard format:
    #   {
    #     "2015-01-01": {
    #       "USD": 1.234,
    #       "GBP": 0.876
    #     },
    #     .
    #     .
    #     .
    #   }
    def parse
      parser = @options[:parser].new
      parser.parse(self)
    end
  end
end
