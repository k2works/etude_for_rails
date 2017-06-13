module Payroll
  module TransactionImplementation
    class DeleteEmployeeTransaction
      include TransactionApplicationSource::Transaction

      def initialize(emp_id)
        @its_emp_id = emp_id
      end

      def execute
        PayrollDatabase::GlobalDatabase.instance.payroll_db.delete_employee(@its_emp_id)
      end
    end
  end
end