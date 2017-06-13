module Payroll
  module PayrollImplementation
    class HoldMethod
      include PayrollDomain::PaymentMethod

      def pay(paycheck)
      end
    end
  end
end