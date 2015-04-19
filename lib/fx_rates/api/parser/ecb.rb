require 'nokogiri'
require 'open-uri'

module FxRates
  module Api
    module Parser
      # European Central Bank (ECB) feed. This class is the ECB strategy for
      # parsing the XML and storing caching it in our local store in the
      # standard format that this library expects.
      class Ecb
        API_URL = "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml"

        def parse(context)
          @context = context
          @last_date_processed = @context.options[:store]['last_date_processed']
          doc = Nokogiri::XML(open(API_URL))
          doc.remove_namespaces!
          get_data(doc)
        end

        private

        # Parse the ECB feed then construct and store the standard format JSON
        # in the configured key/value store.
        #
        # doc - The nokogiri document initialized in parse.
        #
        # Returns nothing.
        def get_data(doc)
          snapshots = doc.xpath("//Cube[@time]")
          snapshots.each do |snapshot|
            date_str = snapshot.attr("time")
            date = Date.parse(date_str)
            last_date_processed(date)
            if (date <= @last_date_processed) || @last_date_processed.nil?
              output = {}
              snapshot.children.each do |rate|
                currency = rate.attr('currency')
                rate = rate.attr('rate')
                output[currency] = rate.to_f
                @context.options[:store][date] = output
              end
            end
          end
        end

        # This check allows the process to be called regularly without duplicating
        # data to the key/value store. (This is required since this process will
        # be called by a cron job regularly.
        #
        # date - Current date being processed in the get_data method.
        #
        # Returns nothing.
        def last_date_processed(date)
          if @last_date_processed.nil?
            @last_date_processed = date
          else
            if date > @last_date_processed
              @last_date_processed = date
            end
          end
        end
      end
    end
  end
end
