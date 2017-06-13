module Payroll
  module PayrollImplementation
    class BiweeklySchedule
      include PayrollDomain::PaymentSchedule

      def is_pay_date(pay_date)
        first_day = Date.new(pay_date.year,pay_date.month,1)
        first_paybale_friday = (first_day - (first_day.wday - 5)) + 7

        if pay_date.friday?
          cal = first_paybale_friday
          while cal <= pay_date
            if cal == pay_date
              return true
            end
            cal += 14
          end
          false
        end
      end

      def get_pay_period_start_date(pay_date)
        pay_date - 13
      end
    end
  end
end