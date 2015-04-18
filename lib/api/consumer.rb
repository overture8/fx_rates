$:.unshift File.dirname(__FILE__)

module Api
  class Consumer
    attr_reader :options

    def initialize(options={})
      @options = options
      @options[:store] = ::FxRates.configuration.store
      @options[:parser] = ::FxRates.configuration.parser
      parse
      @options[:store].close
    end

    def parse
      parser = @options[:parser].new
      parser.parse(self)
    end
  end
end
