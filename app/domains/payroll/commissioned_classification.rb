module Payroll
  class CommissionedClassification
    include PaymentClassification

    def initialize(salary, commission_rate)
      @its_salary = salary
      @its_commission_rate = commission_rate
    end

    def get_salary
      @its_salary
    end

    def get_rate
      @its_commission_rate
    end
  end
end