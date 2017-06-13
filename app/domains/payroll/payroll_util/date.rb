module Payroll
  module PayrollUtil
    class Date
      def self.is_between(end_date, start_date, the_date)
        start_date < the_date && end_date >= the_date
      end
    end
  end
end