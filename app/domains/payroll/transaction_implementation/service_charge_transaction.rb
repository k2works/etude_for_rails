module Payroll
  module TransactionImplementation
    class ServiceChargeTransaction
      include TransactionApplicationSource::Transaction

      def initialize(member_id, date, amount)
        @its_member_id = member_id
        @its_date = date
        @its_amount = amount
      end

      def execute
        e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_union_member(@its_member_id)
        affiliation = e.affiliation
        if affiliation.instance_of? PayrollImplementation::UnionAffiliation
          affiliation.add_service_charge(@its_date, @its_amount)
        end
      end
    end
  end
end