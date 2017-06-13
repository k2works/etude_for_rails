module Payroll
  module PayrollImplementation
    class UnionAffiliation
      include PayrollDomain::Affiliation

      def initialize(member_id=nil, dues)
        @its_service_charges = Hash.new
        @its_member_id = member_id
        @its_dues = dues
      end

      def get_service_charge(date)
        if @its_service_charges.fetch(date).nil?
          return 0
        end
        @its_service_charges.fetch(date).get_amount
      end

      def add_service_charge(date, amount)
        @its_service_charges.store(date, ServiceCharge.new(date, amount))
      end

      def get_member_id
        @its_member_id
      end

      def get_dues
        @its_dues
      end

      def calculate_deductions(paycheck)
        total_service_charge = 0
        total_dues = 0

        @its_service_charges.values.each do |sc|
          if paycheck.pay_period_start_date < sc.get_date && paycheck.pay_period_end_date >= sc.get_date
            total_service_charge += sc.get_amount
          end
        end

        fridays = number_of_fridays_in_pay_period(paycheck.pay_period_start_date, paycheck.pay_period_end_date)
        total_dues = @its_dues * fridays
        total_dues + total_service_charge
      end

      def number_of_fridays_in_pay_period(pay_period_start, pay_period_end)
        fridays = 0
        pay_period = pay_period_start
        while pay_period <= pay_period_end
          fridays += 1 if pay_period.friday?
          pay_period += 1
        end
        fridays
      end
    end
  end
end