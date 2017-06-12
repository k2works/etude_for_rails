module Payroll
  class TimeCardTransaction
    include Transaction

    def initialize(date, hours, emp_id)
      @its_date = date
      @its_hours = hours
      @its_emp_id = emp_id
    end

    def execute
      e = GlobalDatabase.instance.payroll_db.get_employee(@its_emp_id)
      if !e.nil?
        classification = e.classification
        if classification.instance_of? HourlyClassification
          classification.add_time_card(TimeCard.new(@its_date, @its_hours))
        else
          raise StandardError, 'Tried to add timecard to non-hourly employee.'
        end
      else
        raise StandardError, 'No such employee.'
      end
    end
  end
end