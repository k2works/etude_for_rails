module Payroll
  module TransactionImplementation
    class ChangeCommissionedTransaction < AbstractTransactions::ChangeClassificationTransaction
      def initialize(emp_id, salary, hourly_rate, payroll_factory)
        super(emp_id)
        @its_salary = salary
        @its_hourly_rate = hourly_rate
        @its_payroll_factory = payroll_factory
      end

      def get_schedule
        @its_payroll_factory.make_biweekly_schedule
      end

      def get_classification
        @its_payroll_factory.make_commissioned_classification(@its_salary, @its_hourly_rate)
      end
    end
  end
end
