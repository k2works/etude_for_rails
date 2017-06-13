module Payroll
  module PayrollImplementation
    class PaycheckImplementation
      include PayrollDomain::Paycheck

      attr_reader :pay_period_start_date,:pay_period_end_date
      attr_accessor :gross_pay,:deductions,:net_pay

      def initialize(pay_period_start_date, pay_period_end_date)
        @pay_period_start_date = pay_period_start_date
        @pay_period_end_date = pay_period_end_date
      end

      def get_pay_period_start_date
        @pay_period_start_date
      end

      def get_pay_period_end_date
        @pay_period_end_date
      end

      def get_gross_pay
        @gross_pay
      end

      def get_field(string)
        if string == 'Disposition'
          return 'Hold'
        end
        nil
      end

      def get_deductions
        @deductions
      end

      def set_deductions(deductions)
        @deductions = deductions
      end

      def get_net_pay
        @net_pay
      end

      def set_net_pay(net_pay)
        @net_pay = net_pay
      end
    end
  end
end