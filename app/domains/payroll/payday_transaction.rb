module Payroll
  class PaydayTransaction
    include Transaction

    def initialize(pay_date)
      @its_pay_date = pay_date
      @its_pay_checks = Hash.new
    end

    def execute
      emp_ids = PayrollDatabase.get_all_employee_ids
      emp_ids.each do |emp_id|
        e = PayrollDatabase.get_employee(emp_id)
        if e.is_pay_date(@its_pay_date)
          pc = Paycheck.new(e.get_pay_period_start_date(@its_pay_date), @its_pay_date)
          @its_pay_checks.store(emp_id, pc)
          e.payday(pc)
        end
      end
    end

    def get_paycheck(emp_id)
      @its_pay_checks.try(:fetch,emp_id,nil)
    end
  end
end