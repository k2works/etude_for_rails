module Payroll
  module TransactionImplementation
    class ChangeCommissionedTransaction < AbstractTransactions::ChangeClassificationTransaction
      def initialize(emp_id, salary, hourly_rate)
        super(emp_id)
        @its_salary = salary
        @its_hourly_rate = hourly_rate
      end

      def get_schedule
        PayrollImplementation::BiweeklySchedule.new
      end

      def get_classification
        PayrollImplementation::CommissionedClassification.new(@its_salary, @its_hourly_rate)
      end
    end
  end
end
