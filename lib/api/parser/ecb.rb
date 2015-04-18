require 'nokogiri'
require 'open-uri'

module Api
  module Parser
    class Ecb
      API_URL = "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml"

      def parse(context)
        @context = context
        doc = Nokogiri::XML(open(API_URL))
        doc.remove_namespaces!
        get_data(doc)
      end

      private

      def get_data(doc)
        snapshots = doc.xpath("//Cube[@time]")
        snapshots.each do |snapshot|
          time = snapshot.attr("time")
          output = {}
          snapshot.children.each do |rate|
            currency = rate.attr('currency')
            rate = rate.attr('rate')
            output[currency] = rate.to_f
            @context.options[:store][time] = output
          end
        end
      end

    end
  end
end
