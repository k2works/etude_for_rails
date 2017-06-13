module Payroll
  module PayrollImplementation
    class DirectMethod
      include PayrollDomain::PaymentMethod

      def initialize(bank, account)
        @its_bank = bank
        @its_account = account
      end

      def get_bank
        @its_bank
      end

      def get_account
        @its_account
      end

      def pay(paycheck)
      end
    end
  end
end