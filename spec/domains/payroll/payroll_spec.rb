require 'rails_helper'
include Payroll

describe Payroll::AddSalariedEmployee do
  def setup_employee
    emp_id = 1
    t = Payroll::AddSalariedEmployee.new(emp_id, 'Bob', 'Home', 1000.00)
    t.execute
    Payroll::PayrollDatabase.get_employee(emp_id)
  end

  describe '#execute' do
    it 'store record' do
      e = setup_employee
      expect(e).not_to be_nil
    end

    it 'recorded name' do
      e = setup_employee
      expect(e.name).to eq('Bob')
    end

    it 'recorded salary' do
      e = setup_employee
      pc = e.classification
      expect(pc).not_to be_nil
      expect(pc.get_salary).to eq(1000.00)
    end

    it 'recorded schedule' do
      e = setup_employee
      ps = e.schedule
      expect(ps).not_to be_nil
    end

    it 'recorded hold method' do
      e = setup_employee
      pm = e.hold_method
      expect(pm).not_to be_nil
    end
  end
end

describe Payroll::AddHourlyEmployee do
  def setup_employee
    emp_id = 2
    t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
    t.execute
    Payroll::PayrollDatabase.get_employee(emp_id)
  end

  describe '#execute' do
    it 'store record' do
      e = setup_employee
      expect(e).not_to be_nil
    end

    it 'recorded name' do
      e = setup_employee
      expect(e.name).to eq('Bill')
    end

    it 'recorded salary' do
      e = setup_employee
      pc = e.classification
      expect(pc).not_to be_nil
      expect(pc.get_rate).to eq(15.25)
    end

    it 'recorded schedule' do
      e = setup_employee
      ps = e.schedule
      expect(ps).not_to be_nil
    end

    it 'recorded hold method' do
      e = setup_employee
      pm = e.hold_method
      expect(pm).not_to be_nil
    end
  end
end

describe Payroll::AddCommissionedEmployee do
  def setup_employee
    emp_id = 3
    t = Payroll::AddCommissionedEmployee.new(emp_id, 'Lance', 'Home', 2500, 3.2)
    t.execute
    Payroll::PayrollDatabase.get_employee(emp_id)
  end

  describe '#execute' do
    it 'store record' do
      e = setup_employee
      expect(e).not_to be_nil
    end

    it 'recorded name' do
      e = setup_employee
      expect(e.name).to eq('Lance')
    end

    it 'recorded salary' do
      e = setup_employee
      pc = e.classification
      expect(pc).not_to be_nil
      expect(pc.get_rate).to eq(3.2)
    end

    it 'recorded schedule' do
      e = setup_employee
      ps = e.schedule
      expect(ps).not_to be_nil
    end

    it 'recorded hold method' do
      e = setup_employee
      pm = e.hold_method
      expect(pm).not_to be_nil
    end
  end
end

describe Payroll::DeleteEmployeeTransaction do
  def setup_employee
    emp_id = 3
    t = Payroll::AddCommissionedEmployee.new(emp_id, 'Lance', 'Home', 2500, 3.2)
    t.execute
    Payroll::PayrollDatabase.get_employee(emp_id)
  end

  describe '#execute' do
    it 'delete record' do
      setup_employee
      dt = Payroll::DeleteEmployeeTransaction.new(emp_id)
      dt.execute
      e = Payroll::PayrollDatabase.get_employee(emp_id)
      expect(e).to be_nil
    end
  end
end