module Payroll
  attr_reader :emp_id
  attr_accessor :name, :address, :classification, :schedule, :hold_method, :affiliation

  class Employee
    def initialize(emp_id, name, address)
      @emp_id = emp_id
      @name = name
      @address = address
    end
  end
end