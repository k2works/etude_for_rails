module DesignPattern
  module Builder
    class Motherboard
      attr_accessor :cpu
      attr_accessor :memory_size
      def initialize(cpu=DesignPattern::Builder::BasicCPU.new, memory_size=1000)
        @cpu = cpu
        @memory_size = memory_size
      end
    end
  end
end