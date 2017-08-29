require 'uri'
module DesignPattern
  module CoC
    class Message
      attr_accessor :from, :to, :body

      def initialize(from, to, body)
        @from = from
        @to = URI.parse(to)
        @body = body
      end
    end
  end
end
