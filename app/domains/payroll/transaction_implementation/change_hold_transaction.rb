module Payroll
  module TransactionImplementation
    class ChangeHoldTransaction < AbstractTransactions::ChangeMethodTransaction
      def initialize(emp_id, payroll_factory)
        super(emp_id)
        @its_payroll_factory = payroll_factory
      end

      def get_method
        @its_payroll_factory.make_hold_method
      end
    end
  end
end