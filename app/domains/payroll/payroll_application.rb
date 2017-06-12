module Payroll
  class PayrollApplication < TransactionApplication

    def initialize
      @transaction_source = TextParserTransactionSource.new
    end

    def set_source(source)
      @transaction_source.set_source(source)
      @transaction_source.execute
    end
  end
end