module Payroll
  class PayrollDatabase
    @@its_employees = Hash.new

    def self.add_employee(emp_id, employee)
      @@its_employees.store(emp_id, employee)
    end

    def self.get_employee(emp_id)
      @@its_employees.fetch(emp_id)
    end

    def self.clear
      @@its_employees.clear
    end
  end
end