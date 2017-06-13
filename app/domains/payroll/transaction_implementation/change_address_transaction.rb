module Payroll
  module TransactionImplementation
    class ChangeAddressTransaction < AbstractTransactions::ChangeEmployeeTransaction
      def initialize(emp_id, address)
        super(emp_id)
        @its_address = address
      end

      def change(employee)
        employee.address = @its_address
      end
    end
  end
end