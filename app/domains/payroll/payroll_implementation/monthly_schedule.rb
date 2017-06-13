module Payroll
  module PayrollImplementation
    class MonthlySchedule
      include PayrollDomain::PaymentSchedule

      def is_pay_date(pay_date)
        is_last_day_of_month(pay_date)
      end

      def get_pay_period_start_date(pay_date)
        Date.new(pay_date.year,pay_date.month,1)
      end

      private
      def is_last_day_of_month(pay_date)
        Date.new(pay_date.year,pay_date.month,-1).day == pay_date.day
      end
    end
  end
end