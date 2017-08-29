require 'find'
module DesignPattern
  module Interpreter
    class Expression
      def |(other)
        Or.new(self, other)
      end

      def &(other)
        And.new(self, other)
      end

      def all
        All.new
      end

      def bigger(size)
        Bigger.new(size)
      end

      def name(pattern)
        FileName.new(pattern)
      end

      def except(expression)
        Not.new(expression)
      end

      def writable
        Writable.new
      end
    end
  end
end
