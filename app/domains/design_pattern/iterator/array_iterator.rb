module DesignPattern
  module Iterator
    class ArrayIterator
      def initialize(array)
        @array = array
        @index = 0
      end

      def has_next?
        @index < @array.length
      end

      def item
        @array[@index]
      end

      def next_item
        value = @array[@index]
        @index += 1
        value
      end

      def self.for_each_element(array)
        i = 0
        while i < array.length
          yield(array[i])
          i += 1
        end
      end
    end
  end
end
