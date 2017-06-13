module Payroll
  module TransactionImplementation
    class ChangeHourlyTransaction < AbstractTransactions::ChangeClassificationTransaction
      def initialize(emp_id, rate)
        super(emp_id)
        @its_rate = rate
      end

      def get_schedule
        PayrollImplementation::WeeklySchedule.new
      end

      def get_classification
        PayrollImplementation::HourlyClassification.new(@its_rate)
      end
    end
  end
end