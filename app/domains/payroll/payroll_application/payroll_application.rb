module Payroll
  module PayrollApplication
    class PayrollApplication < TransactionApplicationSource::TransactionApplication

      def initialize
        @transaction_source = TextParserTransactionSource::TextParserTransactionSource.new
      end

      def set_source(source)
        @transaction_source.set_source(source)
        @transaction_source.execute
      end
    end
  end
end