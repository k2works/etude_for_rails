module Payroll
  module PayrollDatabaseImplementation
    class PayrollDatabaseImplementation
      include PayrollDatabase

      def initialize
        @its_employees = Hash.new
        @its_union_members = Hash.new
      end

      def add_employee(emp_id, employee)
        @its_employees.store(emp_id, employee)
      end

      def get_employee(emp_id)
        @its_employees.try(:fetch, emp_id, nil)
      end

      def delete_employee(its_emp_id)
        @its_employees.delete(its_emp_id)
      end

      def add_union_member(member_id, employee)
        @its_union_members.store(member_id, employee)
      end

      def get_union_member(member_id)
        @its_union_members.try(:fetch, member_id, nil)
      end

      def remove_union_member(member_id)
        @its_union_members.delete(member_id)
      end

      def get_all_employee_ids
        @its_employees.keys
      end
    end
  end
end