module Payroll
  module TransactionImplementation
    class ChangeDirectTransaction < AbstractTransactions::ChangeMethodTransaction
      def initialize(emp_id, bank, account, payroll_factory)
        super(emp_id)
        @its_bank = bank
        @its_account = account
        @its_payroll_factory = payroll_factory
      end

      def get_method
        @its_payroll_factory.make_direct_method(@its_bank, @its_account)
      end
    end
  end
end