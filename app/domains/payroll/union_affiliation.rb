module Payroll
  class UnionAffiliation
    include Affiliation

    def initialize(d)
      @its_service_charges = Hash.new
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
  end
end