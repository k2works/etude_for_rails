module Payroll
  module TransactionImplementation
    class ChangeUnaffiliatedTransaction < AbstractTransactions::ChangeAffiliationTransaction
      def initialize(emp_id, payroll_factory)
        super(emp_id)
        @its_payroll_factory = payroll_factory
      end

      def get_affiliation
        @its_payroll_factory.make_no_affiliation
      end

      def record_membership(employee)
        af = employee.affiliation
        if af.instance_of?(UnionAffiliation)
          member_id = af.get_member_id
          PayrollDatabase::GlobalDatabase.instance.payroll_db.remove_union_member(member_id)
        end
      end
    end
  end
end