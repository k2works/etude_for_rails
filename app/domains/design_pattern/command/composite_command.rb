module DesignPattern
  module Command
    class CompositeCommand < FileCommand
      def initialize
        @commands = []
      end

      def add_command(cmd)
        @commands << cmd
      end

      def execute
        @commands.each { |cmd| cmd.execute }
      end

      def description
        description = ''
        @commands.each { |cmd| description += cmd.description + "\n"}
        description
      end
    end
  end
end