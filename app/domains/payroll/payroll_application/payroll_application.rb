module Payroll
  module PayrollApplication
    class PayrollApplication < TransactionApplicationSource::TransactionApplication

      def initialize
        payroll_factory = PayrollFactoryImplementation.new
        transaction_factory = TransactionFactoryImplementation.new(payroll_factory)
        @transaction_source = TextParserTransactionSource::TextParserTransactionSource.new(transaction_factory)
      end

      def set_source(source)
        @transaction_source.set_source(source)
        @transaction_source.execute
      end
    end
  end
end