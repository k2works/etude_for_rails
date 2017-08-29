require 'net/http'

module DesignPattern
  module Coc
    class HttpAdapter
      def send_message(message)
        Net::HTTP.start(message.to.host, message.to.port) do |http|
          http.post(message.to.path, message.body)
        end
      end
    end

    class HttpAdapterStub < HttpAdapter
      def send_message(message)
        puts message.to.host
        puts message.to.port
        puts message.to.path
        puts message.body
      end
    end
  end
end
