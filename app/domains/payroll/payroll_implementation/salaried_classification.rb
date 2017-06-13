module Payroll
  module PayrollImplementation
    class SalariedClassification
      include PayrollDomain::PaymentClassification

      def initialize(salary)
        @its_salary = salary
      end

      def get_salary
        @its_salary
      end

      def calculate_pay(paycheck)
        @its_salary
      end
    end
  end
end