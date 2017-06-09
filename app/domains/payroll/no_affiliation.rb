module Payroll
  class NoAffiliation
    include Affiliation
    def get_service_charge(date)
      0
    end
  end
end