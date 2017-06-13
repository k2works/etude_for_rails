module Payroll
  module AbstractTransactions
    class ChangeAffiliationTransaction < ChangeEmployeeTransaction
      def initialize(emp_id)
        super(emp_id)
      end

      def change(employee)
        record_membership(employee)
        employee.affiliation = get_affiliation
      end

      def record_membership(employee)
      end

      def get_affiliation
      end
    end
  end
end