module Payroll
  class MailMethod
    include PaymentMethod
    def initialize(address)
      @its_address = address
    end

    def get_address
      @its_address
    end
  end
end