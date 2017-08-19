module DesignPattern
  module Adapter
    class BritishTextObjectAdapter
      def initialize(bto)
        @bto = bto
      end

      def text
        return @bto.string
      end

      def size_inches
        return @bto.size_mm / 25.4
      end

      def color
        return @bto.colour
      end
    end
  end
end