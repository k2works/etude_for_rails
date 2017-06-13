module Payroll
  module AbstractTransactions
    class ChangeClassificationTransaction < ChangeEmployeeTransaction
      def initialize(emp_id)
        super(emp_id)
      end

      def change(employee)
        employee.schedule = get_schedule
        employee.classification = get_classification
      end

      def get_schedule
      end

      def get_classification
      end
    end
  end
end