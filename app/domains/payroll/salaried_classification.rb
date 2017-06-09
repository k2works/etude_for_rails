module Payroll
  class SalariedClassification
    include PaymentClassification

    def initialize(salary)
      @its_salary = salary
    end

    def get_salary
      @its_salary
    end

    def calculate_pay(paycheck)
      @its_salary
    end
  end
end