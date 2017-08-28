module DesignPattern
  module Builder
    class ComputerBuilder
      attr_reader :computer

      def initialize
        @computer = Computer.new
      end

      def turbo(has_turbo_cpu=true)
        @computer.motherboard.cpu = TurboCPU.new
      end

      def memory_size(size_in_mb)
        @computer.motherboard.memory_size = size_in_mb
      end
    end
  end
end
