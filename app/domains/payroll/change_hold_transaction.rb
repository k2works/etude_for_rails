module Payroll
  class ChangeHoldTransaction < ChangeMethodTransaction
    def initialize(emp_id)
      super(emp_id)
    end

    def get_method
      HoldMethod.new
    end
  end
end