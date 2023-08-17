require 'hashie/mash'

module GarageClient
  class Response
    # Simpler implementation of FaradayMiddleware::Mashify to remove `faraday_middleware` dependency
    class Mashify < Faraday::Middleware
      def on_complete(env)
        env[:body] = parse(env[:body])
      end

      def parse(body)
        case body
        when Hash
          ::Hashie::Mash.new(body)
        when Array
          body.map { |item| parse(item) }
        else
          body
        end
      end
    end
  end
end
