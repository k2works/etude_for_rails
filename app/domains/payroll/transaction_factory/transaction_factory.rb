module Payroll
  module TransactionFactory
    module TransactionFactory
      def make_add_commissioned_employee(emp_id, address, salary, commission_rate)
      end

      def make_add_hourly_employee(emap_id, name, address, hourly_rate)
      end

      def make_add_salaried_employee(emp_id, name, address, salary)
      end

      def make_change_commissioned_transaction(emp_id, salary, hourly_rate)
      end

      def make_change_direct_transaction(emp_id, bank, account)
      end

      def make_change_address_transaction(emp_id, address)
      end

      def make_change_hold_transaction(emp_id)
      end

      def make_change_hourly_transaction(emp_id, rate)
      end

      def make_change_mail_transaction(emp_id, rate)
      end

      def make_change_member_transaction(emp_id, memeber_id, dues)
      end

      def make_change_name_transaction(emp_id, name)
      end

      def make_change_salaried_transaction(emp_id, salary)
      end

      def make_change_unaffiliated_transaction(emp_id)
      end

      def make_delete_employee_transaction(emp_id)
      end

      def make_payday_transaction(pay_date)
      end

      def make_sales_receipt_transaction(sale_date, amount, emp_id)
      end

      def make_service_charge_transaction(member_id, date, double, amount)
      end

      def make_time_card_transaction(date, hours, emp_id)
      end
    end
  end
end