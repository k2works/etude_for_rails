module Payroll
  class AddHourlyEmployee < AddEmployeeTransaction
    def initialize(emp_id, name, address, hourly_rate)
      super(emp_id, name, address)
      @its_hourly_rate = hourly_rate
    end

    def get_classification
      HourlyClassification.new(@its_hourly_rate)
    end

    def get_schedule
      WeeklySchedule.new
    end
  end
end