module DesignPattern
  module Factory
    class DuckPond < Pond
      def new_organism(type,name)
        Duck.new(name)
      end
    end
  end
end
