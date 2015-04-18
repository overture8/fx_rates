require "api/consumer"
require "api/parser/ecb"

desc "Consumes data from a given API, formats it and caches in a key/value store of your choice"
task :consume_api do

  # Pick your prefered key/value store
  ::FxRates.configure do |config|
    config.parser = Api::Parser::Ecb
    config.store = Moneta.new(:LRUHash)
  end

  # Use API Strategy to get data
  Api::Consumer.new

end
