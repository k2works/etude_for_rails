module Payroll
  class ChangeNameTransaction < ChangeEmployeeTransaction

    def initialize(emp_id, name)
      super(emp_id)
      @its_name = name
    end

    def change(employee)
      employee.name = @its_name
    end
  end
end