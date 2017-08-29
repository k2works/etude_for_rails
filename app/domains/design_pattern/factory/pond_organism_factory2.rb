module DesignPattern
  module Factory
    class PondOrganismFactory2
      def new_animal(name)
        Frog.new(name)
      end

      def new_plant(name)
        Algae.new(name)
      end
    end
  end
end
