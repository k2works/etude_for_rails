module Payroll
  class HourlyClassification
    include PaymentClassification

    def initialize(hourly_rate)
      @its_hourly_rate = hourly_rate
    end

    def get_rate
      @its_hourly_rate
    end
  end
end