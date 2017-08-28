module DesignPattern
  module Factory
    class FrogPond < Pond
      def new_animal(name)
        Frog.new(name)
      end
    end
  end
end