module Payroll
  class ChangeDirectTransaction < ChangeMethodTransaction
    def initialize(emp_id, bank, account)
      super(emp_id)
      @its_bank = bank
      @its_account = account
    end

    def get_method
      DirectMethod.new(@its_bank, @its_account)
    end
  end
end