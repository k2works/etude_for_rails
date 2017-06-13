module Payroll
  module TransactionImplementation
    class TransactionFactoryImplementation
      include TransactionFactory::TransactionFactory

      def initialize(payroll_factory)
        @its_payroll_factory = payroll_factory
      end

      def make_add_commissioned_employee(emp_id, name, address, salary, commission_rate)
        AddCommissionedEmployee.new(emp_id,name, address, salary, commission_rate,@its_payroll_factory)
      end

      def make_add_hourly_employee(emap_id, name, address, hourly_rate)
        AddHourlyEmployee.new(emap_id,name,address,hourly_rate,@its_payroll_factory)
      end

      def make_add_salaried_employee(emp_id, name, address, salary)
        AddSalariedEmployee.new(emp_id, name, address, salary, @its_payroll_factory)
      end

      def make_change_address_transaction(emp_id, address)
        ChangeAddressTransaction.new(emp_id, address)
      end

      def make_change_commissioned_transaction(emp_id, salary, hourly_rate)
        ChangeCommissionedTransaction.new(emp_id, salary, hourly_rate, @its_payroll_factory)
      end

      def make_change_direct_transaction(emp_id, bank, account)
        ChangeDirectTransaction.new(emp_id, bank, account, @its_payroll_factory)
      end

      def make_change_hold_transaction(emp_id)
        ChangeHoldTransaction.new(emp_id, @its_payroll_factory)
      end

      def make_change_hourly_transaction(emp_id, rate)
        ChangeHourlyTransaction.new(emp_id, rate, @its_payroll_factory)
      end

      def make_change_mail_transaction(emp_id, address)
        ChangeMailTransaction.new(emp_id, address, @its_payroll_factory)
      end

      def make_change_member_transaction(emp_id, memeber_id, dues)
        ChangeMemberTransaction.new(emp_id, memeber_id, dues, @its_payroll_factory)
      end

      def make_change_name_transaction(emp_id, name)
        ChangeNameTransaction.new(emp_id, name)
      end

      def make_change_salaried_transaction(emp_id, salary)
        ChangeSalariedTransaction.new(emp_id, salary, @its_payroll_factory)
      end

      def make_change_unaffiliated_transaction(emp_id)
        ChangeUnaffiliatedTransaction.new(emp_id, @its_payroll_factory)
      end

      def make_delete_employee_transaction(emp_id)
        DeleteEmployeeTransaction.new(emp_id)
      end

      def make_payday_transaction(pay_date)
        PaydayTransaction.new(pay_date, @its_payroll_factory)
      end

      def make_sales_receipt_transaction(sale_date, amount, emp_id)
        SalesReceiptTransaction.new(sale_date, amount, emp_id)
      end

      def make_service_charge_transaction(member_id, date, double, amount)
        ServiceChargeTransaction.new(member_id, date, amount)
      end

      def make_time_card_transaction(date, hours, emp_id)
        TimeCardTransaction.new(date, hours, emp_id)
      end
    end
  end
end