module DesignPattern
  module Factory
    class IOFactory
      def initialize(format)
        @reader_class = self.class.const_get("DesignPattern::Factory::#{format}Reader")
        @writer_class = self.class.const_get("DesignPattern::Factory::#{format}Writer")
      end

      def new_reader
        @reader_class.new
      end

      def new_writer
        @writer_class.new
      end
    end

    class HTMLReader; end

    class HTMLWriter; end

    class PDFReader; end

    class PDFWriter; end
  end
end
