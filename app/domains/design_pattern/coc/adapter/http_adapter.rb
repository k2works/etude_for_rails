require 'net/http'

module DesignPattern
  module CoC
    class HttpAdapter
      def send_message(message)
        Net::HTTP.start(message.to.host, message.to.port) do |http|
          http.post(message.to.path, message.body)
        end
      end
    end
  end
end
