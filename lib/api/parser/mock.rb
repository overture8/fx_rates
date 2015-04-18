module Api
  module Parser
    class Mock
      def parse(context)
        @context = context
        get_data
      end

      private

      def get_data
        output = {}

        @context.options[:store]["2015-01-01"] = {
          "USD" => 1.0814,
          "JPY" => 128.45
        }
      end
    end
  end
end
