require "fx_rates/api/consumer"
include FxRates

desc "Consumes data from a given API, formats it and caches in a key/value store of your choice"
task :consume_api => [:environment] do
  # Start consumer process

  puts FxRates.configuration.inspect

  Api::Consumer.new
end
