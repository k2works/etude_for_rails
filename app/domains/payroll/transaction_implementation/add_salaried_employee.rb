module Payroll
  module TransactionImplementation
    class AddSalariedEmployee < AbstractTransactions::AddEmployeeTransaction
      def initialize(emp_id, name, address, salary, payroll_factory)
        super(emp_id, name, address, payroll_factory)
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