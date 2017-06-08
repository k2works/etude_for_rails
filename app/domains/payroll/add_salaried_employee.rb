module Payroll
  class AddSalariedEmployee < AddEmployeeTransaction

    def initialize(emp_id, name, address, salary)
      super(emp_id, name, address)
      @its_salary = salary
    end

    def get_classification
      SalariedClassification.new(@its_salary)
    end

    def get_schedule
      MonthlySchedule.new
    end
  end
end