module DesignPattern
  module Composite
    class AddLiquidsTask < Task

      def initialize
        super('Add Liquids')
      end

      def get_time_required
        10.0
      end
    end
  end
end