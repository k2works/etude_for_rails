module Payroll
  class WeeklySchedule
    include PaymentSchedule

    def is_pay_date(pay_date)
      false
    end

    def get_pay_period_start_date(pay_date)
      nil
    end

  end
end