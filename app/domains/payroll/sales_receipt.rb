module Payroll
  class SalesReceipt
    def initialize(sale_date, amount)
      @its_sale_date = sale_date
      @its_amount = amount
    end

    def get_sale_date
      @its_sale_date
    end

    def get_amount
      @its_amount
    end
  end
end