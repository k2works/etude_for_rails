module Payroll
  class ChangeMailTransaction < ChangeMethodTransaction
    def initialize(emp_id, address)
      super(emp_id)
      @its_address = address
    end

    def get_method
      MailMethod.new(@its_address)
    end
  end
end