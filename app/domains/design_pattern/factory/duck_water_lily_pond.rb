module DesignPattern
  module Factory
    class DuckWaterLilyPond < Pond
      def new_organism(type, name)
        if type == :animal
          Duck.new(name)
        elsif type == :plant
          WaterLily.new(name)
        else
          raise "Unknown organism type: #{type}"
        end
      end
    end
  end
end
