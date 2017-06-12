module Payroll
  class ChangeUnaffiliatedTransaction < ChangeAffiliationTransaction
    def initialize(emp_id)
      super(emp_id)
    end

    def get_affiliation
      NoAffiliation.new
    end

    def record_membership(employee)
      af = employee.affiliation
      if af.instance_of?(UnionAffiliation)
        member_id = af.get_member_id
        GlobalDatabase.instance.payroll_db.remove_union_member(member_id)
      end
    end
  end
end