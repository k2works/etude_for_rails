require 'uri'
module DesignPattern
  module Coc
    class Message
      attr_accessor :from, :to, :body

      def initialize(from, to, body)
        @from = URI.parse(from)
        @to = URI.parse(to)
        @body = body
      end
    end
  end
end
