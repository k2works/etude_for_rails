module DesignPattern
  module Builder
    class DeskTopBuilder < ComputerBuilder
      def initialize
        @computer = DesktopComputer.new
      end

      def display=(display)
        @computer.display=display
      end

      def add_cd(writer=false)
        @computer.drives << Drive.new(:cd, 760, writer)
      end

      def add_dvd(writer=false)
        @computer.drives << Drive.new(:dvd, 4000, writer)
      end

      def add_hard_disk(size_in_mb)
        @computer.drives << Drive.new(:hard_disk, size_in_mb, true)
      end

      def computer
        raise "Not enough memory" if @computer.motherboard.memory_size < 250
        raise "Too many drives" if @computer.drives.size > 4
        hard_disk = @computer.drives.find {|drive| drive.type == :hard_disk}
        raise "No hard disk." unless hard_disk
        @computer
      end
    end
  end
end