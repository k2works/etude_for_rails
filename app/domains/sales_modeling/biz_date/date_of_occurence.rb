# frozen_string_literal: true

module SalesModeling
  module BizDate
    module DateOfOccurrences
      include SalesModeling::Date

      attr_reader :date

      def initialize(date)
        @date = date
      end
    end
  end
end
