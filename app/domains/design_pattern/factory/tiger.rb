module DesignPattern
  module Factory
    class Tiger
      def initialize(name)
        @name = name
      end

      def eat
        puts("トラ #{@name}は食べたいものを何でも食べます。")
      end

      def speak
        puts("トラ #{@name}はガオーとほえています。")
      end

      def sleep
        puts("トラ #{@name}は眠たくなったら眠ります。")
      end
    end
  end
end
