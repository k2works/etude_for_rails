module Payroll
  module PayrollImplementation
    class ServiceCharge
      def initialize(date, amount)
        @its_date = date
        @its_amount = amount
      end

      def get_date
        @its_date
      end

      def get_amount
        @its_amount
      end
    end
  end
end