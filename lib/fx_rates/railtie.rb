require 'fx_rates'
require 'rails'

module FxRates
  class Railtie < Rails::Railtie
    railtie_name :FxRates

    rake_tasks do
      load "tasks/api_consumer.rake"
    end
  end
end
