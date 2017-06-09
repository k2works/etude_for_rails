module Payroll
  class PayrollDatabase
    @@its_employees = Hash.new
    @@its_union_members = Hash.new

    def self.add_employee(emp_id, employee)
      @@its_employees.store(emp_id, employee)
    end

    def self.get_employee(emp_id)
      @@its_employees.try(:fetch, emp_id, nil)
    end

    def self.delete_employee(its_emp_id)
      @@its_employees.delete(its_emp_id)
    end

    def self.add_union_member(member_id, employee)
      @@its_union_members.store(member_id, employee)
    end

    def self.get_union_member(member_id)
      @@its_union_members.try(:fetch, member_id, nil)
    end

    def self.remove_union_member(member_id)
      @@its_union_members.delete(member_id)
    end

    def self.get_all_employee_ids
      @@its_employees.keys
    end
  end
end