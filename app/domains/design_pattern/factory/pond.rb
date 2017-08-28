module DesignPattern
  module Factory
    class Pond
      def initialize(number_animals, number_plants)
        @animals = []
        number_animals.times do |i|
          animal = new_organism(:animal, "動物#{i}")
          @animals << animal
        end

        @plants = []
        number_plants.times do |i|
          plant = new_organism(:plant, "植物#{i}")
          @plants << plant
        end
      end

      def simulate_one_day
        @plants.each { |plant| plant.grow }
        @animals.each { |animal| animal.speak }
        @animals.each { |animal| animal.eat }
        @animals.each { |animal| animal.sleep }
      end
    end
  end
end