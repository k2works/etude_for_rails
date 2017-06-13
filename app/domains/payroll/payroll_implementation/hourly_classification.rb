module Payroll
  module PayrollImplementation
    class HourlyClassification
      include PayrollDomain::PaymentClassification

      def initialize(hourly_rate)
        @its_time_cards = Hash.new
        @its_hourly_rate = hourly_rate
      end

      def get_rate
        @its_hourly_rate
      end

      def get_time_card(date)
        @its_time_cards.try(:fetch,date,nil)
      end

      def add_time_card(tc)
        @its_time_cards.store(tc.get_date, tc)
      end

      def calculate_pay(paycheck)
        total_pay = 0
        @its_time_cards.values.each do |tc|
          the_date = tc.get_date
          start_date = paycheck.pay_period_start_date
          end_date = paycheck.pay_period_end_date
          if PayrollUtil::Date.is_between(end_date, start_date, the_date)
            if 8 < tc.get_hours
              total_pay += @its_hourly_rate * 8 + @its_hourly_rate * (tc.get_hours - 8) * 1.5
            else
              total_pay += @its_hourly_rate * tc.get_hours
            end
          end
        end
        total_pay
      end
    end
  end
end