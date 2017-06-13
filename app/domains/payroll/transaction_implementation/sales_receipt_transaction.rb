module Payroll
  module TransactionImplementation
    class SalesReceiptTransaction
      include TransactionApplicationSource::Transaction

      def initialize(sale_date, amount, emp_id)
        @its_sale_date = sale_date
        @its_amount = amount
        @its_emp_id = emp_id
      end

      def execute
        e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(@its_emp_id)
        if !e.nil?
          classification = e.classification
          if classification.instance_of? PayrollImplementation::CommissionedClassification
            classification.add_receipt(PayrollImplementation::SalesReceipt.new(@its_sale_date, @its_amount))
          else
            raise StandardError, 'Tried to add sales receipt to non-commissioned employee'
          end
        else
          raise StandardError, 'No such employee.'
        end
      end
    end
  end
end