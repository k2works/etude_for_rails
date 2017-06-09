module Payroll
  class ChangeMethodTransaction < ChangeEmployeeTransaction
    def initialize(emp_id)
      super(emp_id)
    end

    def change(employee)
      employee.hold_method = get_method
    end

    def get_method
    end
  end
end