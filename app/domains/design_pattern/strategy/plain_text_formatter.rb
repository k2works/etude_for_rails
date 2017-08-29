module DesignPattern
  module Strategy
    class PlainTextFormatter
      def output_report(context)
        puts("**** #{context.title} ****")
        context.text.each do |line|
          puts(line)
        end
      end
    end
  end
end
