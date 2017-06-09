module Payroll
  class ChangeSalariedTransaction < ChangeClassificationTransaction
    def initialize(emp_id, salary)
      super(emp_id)
      @its_salary = salary
    end

    def get_schedule
      MonthlySchedule.new
    end

    def get_classification
      SalariedClassification.new(@its_salary)
    end
  end
end