module Payroll
  module TransactionImplementation
    class ChangeHourlyTransaction < AbstractTransactions::ChangeClassificationTransaction
      def initialize(emp_id, rate, payroll_factory)
        super(emp_id)
        @its_rate = rate
        @its_payroll_factory = payroll_factory
      end

      def get_schedule
        @its_payroll_factory.make_weekly_schedule
      end

      def get_classification
        @its_payroll_factory.make_hourly_classification(@its_rate)
      end
    end
  end
end