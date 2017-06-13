module Payroll
  module TransactionImplementation
    class ChangeMailTransaction < AbstractTransactions::ChangeMethodTransaction
      def initialize(emp_id, address, payroll_factory)
        super(emp_id)
        @its_address = address
        @its_payroll_factory = payroll_factory
      end

      def get_method
        @its_payroll_factory.make_mail_method(@its_address)
      end
    end
  end
end