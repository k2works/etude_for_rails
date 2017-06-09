module Payroll
  class CommissionedClassification
    include PaymentClassification

    def initialize(salary, commission_rate)
      @its_salary = salary
      @its_commission_rate = commission_rate
      @its_receipts = Hash.new
    end

    def get_salary
      @its_salary
    end

    def get_rate
      @its_commission_rate
    end

    def add_receipt(sr)
      @its_receipts.store(sr.get_sale_date,sr)
    end

    def get_receipt(date)
      @its_receipts.fetch(date)
    end

    def calculate_pay(paycheck)
      0
    end
  end
end