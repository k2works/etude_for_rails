module Payroll
  class ChangeHourlyTransaction < ChangeClassificationTransaction
    def initialize(emp_id, rate)
      super(emp_id)
      @its_rate = rate
    end

    def get_schedule
      WeeklySchedule.new
    end

    def get_classification
      HourlyClassification.new(@its_rate)
    end
  end
end