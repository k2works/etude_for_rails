module Payroll
  class AddCommissionedEmployee < AddEmployeeTransaction
    def initialize(emp_id, name, address, salary, commission_rate)
      super(emp_id, name, address)
      @its_salary = salary
      @its_commission_rate = commission_rate
    end

    def get_classification
      CommissionedClassification.new(@its_salary, @its_commission_rate)
    end

    def get_schedule
      BiweeklySchedule.new
    end
  end
end