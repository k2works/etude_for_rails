module Payroll
  class ChangeCommissionedTransaction < ChangeClassificationTransaction
    def initialize(emp_id, salary, hourly_rate)
      super(emp_id)
      @its_salary = salary
      @its_hourly_rate = hourly_rate
    end

    def get_schedule
      BiweeklySchedule.new
    end

    def get_classification
      CommissionedClassification.new(@its_salary, @its_hourly_rate)
    end
  end
end
