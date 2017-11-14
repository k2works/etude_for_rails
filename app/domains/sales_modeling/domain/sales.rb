# frozen_string_literal: true

module SalesModeling
  module Domain
    module Sales
      attr_reader :type,
                  :date_of_occurrence,
                  :sales_price,
                  :sales_lines

      def initialize
        @sales_lines = []
      end

      def date_of_occurrence=(date)
        @date_of_occurrence = SalesModeling::Date::DateOfOccurrences.new(date)
      end

      def sales_price=(amount)
        @sales_price = SalesModeling::Price::SalesPrice.new(amount)
      end

      def sales_lines
        @sales_lines << SalesModeling::Domain::Sales::SalesLine.new
      end
    end
  end
end
