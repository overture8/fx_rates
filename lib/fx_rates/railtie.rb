require 'fx_rates'
require 'rails'

# This railtie only exists to load the rake task (tasks/api_consumer.rake)
# in the Rails environment. The library works fine without this code so is
# not coupled with Rails otherwise.
module FxRates
  class Railtie < Rails::Railtie
    railtie_name :FxRates

    rake_tasks do
      load "#{File.dirname(__FILE__)}/tasks/api_consumer.rake"
    end
  end
end
