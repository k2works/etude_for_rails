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

      def self.change_resitant_for_each_element(array)
        copy = Array.new(array)
        i = 0
        while i < copy.length
          yield(copy[i])
          i += 1
        end
      end

      def self.merge(array1, array2)
        merged = []

        iterator1 = ArrayIterator.new(array1)
        iterator2 = ArrayIterator.new(array2)

        while( iterator1.has_next? and iterator2.has_next?)
          if iterator1.item < iterator2.item
            merged << iterator1.next_item
          else
            merged << iterator2.next_item
          end
        end

        # array1から残りを取り出す
        while(iterator1.has_next?)
          merged << iterator1.next_item
        end

        # array2から残りを取り出す
        while(iterator2.has_next?)
          merged << iterator2.next_item
        end
        merged
      end
    end
  end
end
