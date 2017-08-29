module DesignPattern
  module Command
    class FileCommand
      attr_reader :description

      def initialize(description)
        @description = description
      end

      def execute
      end
    end
  end
end