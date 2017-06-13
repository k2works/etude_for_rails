module Payroll
  module TransactionImplementation
    class ChangeMemberTransaction < AbstractTransactions::ChangeAffiliationTransaction
      def initialize(emp_id, member_id, dues)
        super(emp_id)
        @its_member_id = member_id
        @its_dues = dues
      end

      def get_affiliation
        UnionAffiliation.new(@its_member_id, @its_dues)
      end

      def record_membership(employee)
        PayrollDatabase::GlobalDatabase.instance.payroll_db.add_union_member(@its_member_id, employee)
      end
    end
  end
end