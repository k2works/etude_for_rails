module Payroll
  module AbstractTransactions
    class AddEmployeeTransaction
      include TransactionApplicationSource::Transaction

      def initialize(emp_id, name, address, payroll_factory)
        @its_emp_id = emp_id
        @its_name = name
        @its_address = address
        @its_payroll_factory = payroll_factory
      end

      def execute
        pc = get_classification
        ps = get_schedule
        pm = PayrollImplementation::HoldMethod.new
        e = PayrollDomain::Employee.new(@its_emp_id, @its_name, @its_address)
        e.classification = pc
        e.schedule = ps
        e.hold_method = pm
        PayrollDatabase::GlobalDatabase.instance.payroll_db.add_employee(@its_emp_id, e)
      end

      def get_schedule
      end

      def get_classification
      end
    end
  end
end