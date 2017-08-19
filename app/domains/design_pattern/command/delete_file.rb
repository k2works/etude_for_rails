module DesignPattern
  module Command
    class DeleteFile < FileCommand
      def initialize(path)
        super("Delete file: #{path}")
        @path = path
      end

      def execute
        if File.exist?(@path)
          @contents = File.read(@path)
        end
        f = File.delete(@path)
      end

      def unexecute
        if @contents
          f = File.open(@path, "w")
          f.write(@contents)
          f.close
        end
      end
    end
  end
end