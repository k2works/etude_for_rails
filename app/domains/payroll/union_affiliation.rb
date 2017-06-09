module Payroll
  class UnionAffiliation
    include Affiliation

    def initialize(member_id=nil, dues)
      @its_service_charges = Hash.new
      @its_member_id = member_id
      @its_dues = dues
    end

    def get_service_charge(date)
      if @its_service_charges.fetch(date).nil?
        return 0
      end
      @its_service_charges.fetch(date).get_amount
    end

    def add_service_charge(date, amount)
      @its_service_charges.store(date, ServiceCharge.new(date, amount))
    end

    def get_member_id
      @its_member_id
    end

    def get_dues
      @its_dues
    end
  end
end