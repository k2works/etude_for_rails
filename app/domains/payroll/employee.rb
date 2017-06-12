module Payroll
  attr_reader :emp_id
  attr_accessor :name, :address, :classification, :schedule, :hold_method, :affiliation

  class Employee
    def initialize(emp_id, name, address)
      @emp_id = emp_id
      @name = name
      @address = address
      @affiliation = NoAffiliation.new
    end

    def is_pay_date(pay_date)
      @schedule.is_pay_date(pay_date)
    end

    def get_pay_period_start_date(pay_date)
      @schedule.get_pay_period_start_date(pay_date)
    end

    def payday(paycheck)
      gross_pay = @classification.calculate_pay(paycheck)
      deductions = @affiliation.calculate_deductions(paycheck)
      net_pay = gross_pay - deductions
      paycheck.gross_pay = gross_pay
      paycheck.deductions = deductions
      paycheck.net_pay = net_pay
      @hold_method.pay(paycheck)
    end
  end
end