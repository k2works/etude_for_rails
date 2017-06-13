module Payroll
  module TransactionImplementation
    class ChangeMailTransaction < AbstractTransactions::ChangeMethodTransaction
      def initialize(emp_id, address)
        super(emp_id)
        @its_address = address
      end

      def get_method
        PayrollImplementation::MailMethod.new(@its_address)
      end
    end
  end
end