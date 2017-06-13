
module Payroll
  module TransactionImplementation
    class AddCommissionedEmployee < AbstractTransactions::AddEmployeeTransaction
      def initialize(emp_id, name, address, salary, commission_rate, payroll_factory)
        super(emp_id, name, address, payroll_factory)
        @its_salary = salary
        @its_commission_rate = commission_rate
      end

      def get_classification
        PayrollImplementation::CommissionedClassification.new(@its_salary, @its_commission_rate)
      end

      def get_schedule
        PayrollImplementation::BiweeklySchedule.new
      end
    end
  end
end