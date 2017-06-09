module Payroll
  class ChangeMemberTransaction < ChangeAffiliationTransaction
    def initialize(emp_id, member_id, dues)
      super(emp_id)
      @its_member_id = member_id
      @its_dues = dues
    end

    def get_affiliation
      UnionAffiliation.new(@its_member_id, @its_dues)
    end

    def record_membership(employee)
      PayrollDatabase.add_union_member(@its_member_id, employee)
    end
  end
end