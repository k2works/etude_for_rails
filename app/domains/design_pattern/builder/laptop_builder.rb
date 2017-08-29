module DesignPattern
  module Builder
    class LaptopBuilder < ComputerBuilder
      def initialize
        @computer = LaptopComputer.new
      end

      def display=(display)
        raise "Laptop display must be lcd" unless display == :lcd
      end

      def add_cd(writer=false)
        @computer.drives << LaptopDrive.new(:cd, 760, writer)
      end

      def add_dvd(writer=false)
        @computer.drives << LaptopDrive.new(:dvd, 4000, writer)
      end

      def add_hard_disk(size_in_mb)
        @computer.drives << LaptopDrive.new(:hard_disk, size_in_mb, true)
      end

      def computer
        raise "Not enough memory" if @computer.motherboard.memory_size < 500
        raise "Too many drives" if @computer.drives.size > 3
        hard_disk = @computer.drives.find {|drive| drive.type == :hard_disk}
        raise "No hard disk." unless hard_disk
        @computer
      end

      def reset
        @computer = LaptopComputer.new
      end
    end
  end
end
