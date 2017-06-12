module Payroll
  class WeeklySchedule
    include PaymentSchedule

    def is_pay_date(pay_date)
      pay_date.wday == 5
    end

    def get_pay_period_start_date(pay_date)
      this_day = Date.new(pay_date.year,pay_date.month,1)
      this_day - (this_day.wday - 5)
    end
  end
end