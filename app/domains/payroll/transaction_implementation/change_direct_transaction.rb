module Payroll
  module TransactionImplementation
    class ChangeDirectTransaction < AbstractTransactions::ChangeMethodTransaction
      def initialize(emp_id, bank, account)
        super(emp_id)
        @its_bank = bank
        @its_account = account
      end

      def get_method
        PayrollImplementation::DirectMethod.new(@its_bank, @its_account)
      end
    end
  end
end