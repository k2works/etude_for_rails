module Payroll
  module TransactionImplementation
    class ChangeSalariedTransaction < AbstractTransactions::ChangeClassificationTransaction
      def initialize(emp_id, salary, payroll_factory)
        super(emp_id)
        @its_salary = salary
        @its_payroll_factory = payroll_factory
      end

      def get_schedule
        @its_payroll_factory.make_monthly_schedule
      end

      def get_classification
        @its_payroll_factory.make_salaried_classification(@its_salary)
      end
    end
  end
end