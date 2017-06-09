module Payroll
  class HourlyClassification
    include PaymentClassification

    def initialize(hourly_rate)
      @its_time_cards = Hash.new
      @its_hourly_rate = hourly_rate
    end

    def get_rate
      @its_hourly_rate
    end

    def get_time_card(date)
      @its_time_cards.fetch(date)
    end

    def add_time_card(tc)
      @its_time_cards.store(tc.get_date, tc)
    end

  end
end