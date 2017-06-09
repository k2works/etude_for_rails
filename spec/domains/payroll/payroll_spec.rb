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

describe Payroll::TimeCardTransaction do
  describe '#execute' do
    it 'store timecard' do
      emp_id = 2
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      tct = Payroll::TimeCardTransaction.new(20011031,8.0,emp_id)
      tct.execute
      e = Payroll::PayrollDatabase.get_employee(emp_id)
      hc = e.classification
      expect(hc).not_to be_nil
      tc = hc.get_time_card(20011031)
      expect(tc).not_to be_nil
      expect(tc.get_hours).to eq(8.0)
    end
  end
end

describe Payroll::SalesReceiptTransaction do
  describe '#execute' do
    it 'store sales receipt' do
      emp_id = 3
      t = Payroll::AddCommissionedEmployee.new(emp_id, 'Lance', 'Home', 2500, 3.2)
      t.execute
      srt = SalesReceiptTransaction.new(20011112, 25000, emp_id)
      srt.execute
      e = Payroll::PayrollDatabase.get_employee(emp_id)
      pc = e.classification
      expect(pc).not_to be_nil
      receipt = pc.get_receipt(20011112)
      expect(receipt).not_to be_nil
      expect(receipt.get_amount).to eq(25000.0)
    end
  end
end

describe Payroll::ServiceChargeTransaction do
  describe '#execute' do
    it 'store service charge' do
      emp_id = 2
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      tct = Payroll::TimeCardTransaction.new(20011031,8.0,emp_id)
      tct.execute
      e = Payroll::PayrollDatabase.get_employee(emp_id)
      af = Payroll::UnionAffiliation.new(12.5)
      e.affiliation = af
      member_id = 86
      Payroll::PayrollDatabase.add_union_member(member_id, e)
      sct = ServiceChargeTransaction.new(member_id, 20011031, 12.95)
      sct.execute
      sc = af.get_service_charge(20011031)
      expect(sc).to eq(12.95)
    end
  end
end

describe Payroll::ChangeNameTransaction do
  describe '#execute' do
    it 'rename employee' do
      emp_id = 2
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      cnt = Payroll::ChangeNameTransaction.new(emp_id, 'Bob')
      cnt.execute
      e = Payroll::PayrollDatabase.get_employee(emp_id)
      expect(e).not_to be_nil
      expect(e.name).to eq('Bob')
    end
  end
end

describe Payroll::ChangeAddressTransaction do
  describe '#execute' do
    it 'rename employee' do
      emp_id = 2
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      cnt = Payroll::ChangeAddressTransaction.new(emp_id, 'Second Home')
      cnt.execute
      e = Payroll::PayrollDatabase.get_employee(emp_id)
      expect(e).not_to be_nil
      expect(e.address).to eq('Second Home')
    end
  end
end

describe Payroll::ChangeHourlyTransaction do
  describe '#execute' do
    it 'change hourly rate' do
      emp_id = 3
      t = Payroll::AddCommissionedEmployee.new(emp_id, 'Lance', 'Home', 2500, 3.2)
      t.execute
      cht = Payroll::ChangeHourlyTransaction.new(emp_id, 27.52)
      cht.execute
      e = Payroll::PayrollDatabase.get_employee(emp_id)
      classification = e.classification
      expect(classification).not_to be_nil
      expect(classification).to be_an_instance_of(Payroll::HourlyClassification)
      expect(classification.get_rate).to eq(27.52)
      schedule = e.schedule
      expect(schedule).to be_an_instance_of(Payroll::WeeklySchedule)
    end
  end
end

describe Payroll::ChangeSalariedTransaction do
  describe '#execute' do
    it 'change hourly rate' do
      emp_id = 3
      t = Payroll::AddCommissionedEmployee.new(emp_id, 'Lance', 'Home', 2500, 3.2)
      t.execute
      cht = Payroll::ChangeSalariedTransaction.new(emp_id, 25000)
      cht.execute
      e = Payroll::PayrollDatabase.get_employee(emp_id)
      classification = e.classification
      expect(classification).not_to be_nil
      expect(classification).to be_an_instance_of(Payroll::SalariedClassification)
      expect(classification.get_salary).to eq(25000.0)
      schedule = e.schedule
      expect(schedule).to be_an_instance_of(Payroll::MonthlySchedule)
    end
  end
end

describe Payroll::ChangeCommissionedTransaction do
  describe '#execute' do
    it 'change salary and hourly rate' do
      emp_id = 2
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      cht = Payroll::ChangeCommissionedTransaction.new(emp_id, 25000, 4.5)
      cht.execute
      e = Payroll::PayrollDatabase.get_employee(emp_id)
      classification = e.classification
      expect(classification).not_to be_nil
      expect(classification).to be_an_instance_of(Payroll::CommissionedClassification)
      expect(classification.get_salary).to eq(25000.0)
      expect(classification.get_rate).to eq(4.5)
      schedule = e.schedule
      expect(schedule).to be_an_instance_of(Payroll::BiweeklySchedule)
    end
  end
end
