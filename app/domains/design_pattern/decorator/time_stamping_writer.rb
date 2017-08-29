module DesignPattern
  module Decorator
    class TimeStampingWriter < WriterDecorator
      def write_line(line)
        @real_writer.write_line("#{Time.new}: #{line}")
      end
    end
  end
end