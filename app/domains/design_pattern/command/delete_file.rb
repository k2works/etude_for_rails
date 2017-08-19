module DesignPattern
  module Command
    class DeleteFile < FileCommand
      def initialize(path)
        super("Delete file: #{path}")
        @path = path
      end

      def execute
        File.delete(@path)
      end
    end
  end
end