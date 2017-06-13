module Payroll
  module PayrollDatabase
    class GlobalDatabase
      include Singleton
      attr_reader :payroll_db

      def initialize
        @payroll_db = PayrollDatabaseImplementation::PayrollDatabaseImplementation.new
      end
    end
  end
end