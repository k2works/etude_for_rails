module Payroll
  class GlobalDatabase
    include Singleton
    attr_reader :payroll_db

    def initialize
      @payroll_db = PayrollDatabaseImplementation.new
    end
  end
end