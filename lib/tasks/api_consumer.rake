require "api/consumer"
require "api/parser/ecb"
require 'fx_rates'
include FxRates

desc "Consumes data from a given API, formats it and caches in a key/value store of your choice"
task :consume_api do
  # Start consumer process
  Api::Consumer.new
end
