module Payroll
  module PayrollImplementation
    class MailMethod
      include PayrollDomain::PaymentMethod
      def initialize(address)
        @its_address = address
      end

      def get_address
        @its_address
      end

      def pay(paycheck)
      end
    end
  end
end