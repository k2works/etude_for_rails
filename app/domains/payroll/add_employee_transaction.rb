module Payroll
  class AddEmployeeTransaction
    include Transaction

    def initialize(emp_id, name, address)
      @its_emp_id = emp_id
      @its_name = name
      @its_address = address
    end

    def execute
      pc = get_classification
      ps = get_schedule
      pm = HoldMethod.new
      e = Employee.new(@its_emp_id, @its_name, @its_address)
      e.classification = pc
      e.schedule = ps
      e.hold_method = pm
      GlobalDatabase.instance.payroll_db.add_employee(@its_emp_id, e)
    end

    def get_schedule
    end

    def get_classification
    end
  end
end