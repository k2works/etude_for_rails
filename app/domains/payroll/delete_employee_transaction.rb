module Payroll
  class DeleteEmployeeTransaction
    include Transaction

    def initialize(emp_id)
      @its_emp_id = emp_id
    end

    def execute
      PayrollDatabase.delete_employee(@its_emp_id)
    end
  end
end