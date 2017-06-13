module Payroll
  module PayrollImplementation
    class PayrollFactoryImplementation
      include PayrollFactory::PayrollFactory

      def make_biweekly_schedule
        BiweeklySchedule.new
      end

      def make_commissioned_classification(salary, commission_rate)
        CommissionedClassification.new(salary, commission_rate)
      end

      def make_direct_method(bank, account)
        DirectMethod.new(bank, account)
      end

      def make_hold_method
        HoldMethod.new
      end

      def make_hourly_classification(hourly_rate)
        HourlyClassification.new(hourly_rate)
      end

      def make_mail_method(address)
        MailMethod.new(address)
      end

      def make_monthly_schedule
        MonthlySchedule.new
      end

      def make_salaried_classification(salary)
        SalariedClassification.new(salary)
      end

      def make_union_affiliation(member_id, dues)
        UnionAffiliation.new(member_id, dues)
      end

      def make_weekly_schedule
        WeeklySchedule.new
      end

      def make_no_affiliation
        PayrollDomain::NoAffiliation.new
      end

      def make_employee(emp_id, name, address)
        PayrollDomain::Employee.new(emp_id, name, address)
      end

      def make_paycheck(pay_period_start_date, pay_date)
        PaycheckImplementation.new(pay_period_start_date, pay_date)
      end
    end
  end
end