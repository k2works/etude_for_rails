module DesignPattern
  module Adapter
    class BritishTextObject
      attr_reader :string, :size_mm, :colour

      def initialize(string, size_mm, colour)
        @string = string
        @size_mm = size_mm
        @colour = colour
      end
    end

    class BritishTextObject
      def color
        return colour
      end

      def text
        return string
      end

      def size_inches
        return size_mm / 25.4
      end
    end
  end
end
