module DesignPattern
  module Observer
    module Subject3
      def initialize
        @observers = []
      end

      def add_observer(&observer)
        @observers << observer
      end

      def delete_observer(observer)
        @observers.delete(observer)
      end

      def notify_observers
        @observers.each do |observer|
          observer.call(self)
        end
      end
    end
  end
end