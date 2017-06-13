module Payroll
  module TransactionImplementation
    class AddHourlyEmployee < AbstractTransactions::AddEmployeeTransaction
      def initialize(emp_id, name, address, hourly_rate)
        super(emp_id, name, address)
        @its_hourly_rate = hourly_rate
      end

      def get_classification
        PayrollImplementation::HourlyClassification.new(@its_hourly_rate)
      end

      def get_schedule
        PayrollImplementation::WeeklySchedule.new
      end
    end
  end
end