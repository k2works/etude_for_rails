module DesignPattern
  module Command
    class CopyFile < FileCommand
      def initialize(source, target)
        super("Copy file: #{source} to #{target}")
        @source = source
        @target = target
      end

      def execute
        FileUtiles.copy(@source, @target)
      end
    end
  end
end