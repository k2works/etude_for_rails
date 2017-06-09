module Payroll
  class ChangeEmployeeTransaction
    include Transaction

    def initialize(emp_id)
      @its_emp_id = emp_id
    end

    def execute
      e = PayrollDatabase.get_employee(@its_emp_id)
      if !e.nil?
        change(e)
      end
    end

    def change(employee)
    end
  end
end