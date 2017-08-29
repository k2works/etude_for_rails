module DesignPattern
  module Builder
    class LaptopComputer < Computer
      def initialize( motherboard=DesignPattern::Builder::Motherboard.new, drives=[])
        super(:lcd, motherboard, drives)
      end

      # ラップトップの詳細に関するたくさんのコード
    end
  end
end
