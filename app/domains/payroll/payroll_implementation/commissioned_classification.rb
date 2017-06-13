module Payroll
  module PayrollImplementation
    class CommissionedClassification
      include PayrollDomain::PaymentClassification

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
        commission = 0.0
        @its_receipts.values.each do |receipt|
          the_date = receipt.get_sale_date
          start_date = paycheck.pay_period_start_date
          end_date = paycheck.pay_period_end_date
          if PayrollUtil::Date.is_between(end_date, start_date, the_date)
            commission += receipt.get_amount * @its_commission_rate
          end
        end
        @its_salary + commission
      end
    end
  end
end