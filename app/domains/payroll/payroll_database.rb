module Payroll
  class PayrollDatabase
    @@its_employees = Hash.new

    def self.add_employee(emp_id, employee)
      @@its_employees.store(emp_id, employee)
    end

    def self.get_employee(emp_id)
      @@its_employees.try(:fetch, emp_id, nil)
    end

    def self.delete_employee(its_emp_id)
      @@its_employees.delete(its_emp_id)
    end
  end
end