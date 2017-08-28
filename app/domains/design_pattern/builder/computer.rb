module DesignPattern
  module Builder
    class Computer
      attr_accessor :display
      attr_reader :motherboard
      attr_reader :drives

      def initialize(display=:crt, motherboard=DesignPattern::Builder::Motherboard.new, drives=[])
        @motherboard = motherboard
        @drives = drives
        @display = display
      end
    end
  end
end
