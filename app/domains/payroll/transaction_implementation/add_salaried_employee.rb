module Payroll
  module TransactionImplementation
    class AddSalariedEmployee < AbstractTransactions::AddEmployeeTransaction
      def initialize(emp_id, name, address, salary)
        super(emp_id, name, address)
        @its_salary = salary
      end

      def get_classification
        PayrollImplementation::SalariedClassification.new(@its_salary)
      end

      def get_schedule
        PayrollImplementation::MonthlySchedule.new
      end
    end
  end
end