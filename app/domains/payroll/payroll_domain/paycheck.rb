module Payroll
  module PayrollDomain
    class Paycheck
      attr_reader :pay_period_start_date,:pay_period_end_date
      attr_accessor :gross_pay,:deductions,:net_pay

      def initialize(pay_period_start_date, pay_period_end_date)
        @pay_period_start_date = pay_period_start_date
        @pay_period_end_date = pay_period_end_date
      end

      def get_field(string)
        if string == 'Disposition'
          return 'Hold'
        end
        nil
      end
    end
  end
end