module Payroll
  class ServiceChargeTransaction
    include Transaction

    def initialize(member_id, date, amount)
      @its_member_id = member_id
      @its_date = date
      @its_amount = amount
    end

    def execute
      e = GlobalDatabase.instance.payroll_db.get_union_member(@its_member_id)
      affiliation = e.affiliation
      if affiliation.instance_of? UnionAffiliation
        affiliation.add_service_charge(@its_date, @its_amount)
      end
    end
  end
end