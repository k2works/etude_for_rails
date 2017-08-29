require 'forwardable'

module DesignPattern
  module Decorator
    class WriterDecorator
      extend Forwardable

      def_delegators :@real_writer, :write_line, :rewind, :pos, :close

      def initialize(real_writer)
        @real_writer = real_writer
      end
    end
  end
end