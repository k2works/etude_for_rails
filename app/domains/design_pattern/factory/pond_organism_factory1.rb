module DesignPattern
  module Factory
    class PondOrganismFactory1
      def new_animal(name)
        Duck.new(name)
      end

      def new_plant(name)
        WaterLily.new(name)
      end
    end
  end
end
