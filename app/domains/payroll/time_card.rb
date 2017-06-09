module Payroll
  class TimeCard
    def initialize(date, hours)
      @its_date = date
      @its_hours = hours
    end

    def get_date
      @its_date
    end

    def get_hours
      @its_hours
    end
  end
end