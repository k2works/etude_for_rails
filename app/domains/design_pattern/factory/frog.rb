module DesignPattern
  module Factory
    class Frog
      def initialize(name)
        @name = name
      end

      def eat
        puts("カエル#{@name}は食事中です。")
      end

      def speak
        puts("カエル#{@name}はゲロゲロと鳴いています。")
      end

      def sleep
        puts("カエル#{@name}は眠りません。一晩中ゲロゲロ鳴いています。")
      end
    end
  end
end