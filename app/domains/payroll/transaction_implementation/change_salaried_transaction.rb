module Payroll
  module TransactionImplementation
    class ChangeSalariedTransaction < AbstractTransactions::ChangeClassificationTransaction
      def initialize(emp_id, salary)
        super(emp_id)
        @its_salary = salary
      end

      def get_schedule
        PayrollImplementation::MonthlySchedule.new
      end

      def get_classification
        PayrollImplementation::SalariedClassification.new(@its_salary)
      end
    end
  end
end