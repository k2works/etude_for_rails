module DesignPattern
  module Strategy
    class Formatter
      def output_report( title, text)
        raise 'Abstract method called'
      end
    end
  end
end
