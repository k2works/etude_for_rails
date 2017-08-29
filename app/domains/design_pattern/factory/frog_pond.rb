module DesignPattern
  module Factory
    class FrogPond < Pond
      def new_organism(type,name)
        Frog.new(name)
      end
    end
  end
end