module Api
  module Parser
    # This strategy is just used for testing.
    class Mock
      def parse(context)
        @context = context
        get_data
      end

      private

      def get_data
        output = {}
        date = Date.parse("2015-01-01")

        @context.options[:store][date] = {
          "USD" => 1.0814,
          "JPY" => 128.45
        }
      end
    end
  end
end
