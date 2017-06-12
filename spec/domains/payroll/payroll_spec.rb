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

describe Payroll::ChangeMailTransaction do
  describe '#execute' do
    it 'change mail send address' do
      emp_id = 2
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      cmt = Payroll::ChangeMailTransaction.new(emp_id, '4080 El Cerrito Road')
      cmt.execute
      e = Payroll::PayrollDatabase.get_employee(emp_id)
      hold_method = e.hold_method
      expect(hold_method).to be_an_instance_of(Payroll::MailMethod)
      expect(hold_method.get_address).to eq('4080 El Cerrito Road')
    end
  end
end

describe Payroll::ChangeDirectTransaction do
  describe '#execute' do
    it 'change direct' do
      emp_id = 2
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      cdt = Payroll::ChangeDirectTransaction.new(emp_id, 'FirstNational', '1058209')
      cdt.execute
      e = Payroll::PayrollDatabase.get_employee(emp_id)
      hold_method = e.hold_method
      expect(hold_method).to be_an_instance_of(Payroll::DirectMethod)
      expect(hold_method.get_bank).to eq('FirstNational')
      expect(hold_method.get_account).to eq('1058209')
    end
  end
end

describe Payroll::ChangeHoldTransaction do
  describe '#execute' do
    it 'change payment method' do
      emp_id = 2
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      cht = ChangeHoldTransaction.new(emp_id)
      cht.execute
      e = Payroll::PayrollDatabase.get_employee(emp_id)
      payment_method = e.hold_method
      expect(payment_method).not_to be_nil
      expect(payment_method).to be_an_instance_of(Payroll::HoldMethod)
    end
  end
end

describe Payroll::ChangeMemberTransaction do
  describe '#execute' do
    it 'change union affiliation' do
      emp_id = 2
      member_id = 7734
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      cmt = Payroll::ChangeMemberTransaction.new(emp_id, member_id, 99.42)
      cmt.execute
      e = Payroll::PayrollDatabase.get_employee(emp_id)
      affiliation = e.affiliation
      expect(affiliation).to be_an_instance_of(Payroll::UnionAffiliation)
      expect(affiliation.get_dues).to eq(99.42)
      member = Payroll::PayrollDatabase.get_union_member(member_id)
      expect(member).not_to be_nil
      expect(member).to eq(e)
    end
  end
end

describe Payroll::ChangeUnaffiliatedTransaction do
  describe '#execute' do
    it 'delete union member' do
      emp_id = 2
      member_id = 7734
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      cmt = Payroll::ChangeMemberTransaction.new(emp_id, member_id, 99.42)
      cmt.execute
      cuat = Payroll::ChangeUnaffiliatedTransaction.new(emp_id)
      cuat.execute
      e = Payroll::PayrollDatabase.get_employee(emp_id)
      affiliation = e.affiliation
      expect(affiliation).to be_an_instance_of(Payroll::NoAffiliation)
      expect(affiliation.get_service_charge(20011031)).to eq(0)
      member = Payroll::PayrollDatabase.get_union_member(member_id)
      expect(member).to be_nil
    end
  end
end

describe Payroll::PaydayTransaction do
  def validate_paycheck(emp_id, pay, pay_date, pt)
    pc = pt.get_paycheck(emp_id)
    expect(pc.pay_period_end_date).to eq(pay_date)
    expect(pc.gross_pay).to eq(pay)
    expect(pc.get_field('Disposition')).to eq('Hold')
    expect(pc.deductions).to eq(0.0)
    expect(pc.net_pay).to eq(pay)
  end

  describe '#execute' do
    it 'create pay check for single salaried employee' do
      emp_id = 1
      t = Payroll::AddSalariedEmployee.new(emp_id, 'Bob', 'Home', 1000.00)
      t.execute
      pay_date = Date.new(2001,11,30)
      pt = Payroll::PaydayTransaction.new(pay_date)
      pt.execute
      validate_paycheck(emp_id, 1000.00, pay_date, pt)
    end

    it 'not create pay check for single salaried employee on wrong date' do
      emp_id = 1
      t = Payroll::AddSalariedEmployee.new(emp_id, 'Bob', 'Home', 1000.00)
      t.execute
      pay_date = Date.new(2001,11,29)
      pt = Payroll::PaydayTransaction.new(pay_date)
      pt.execute
      pc = pt.get_paycheck(emp_id)
      expect(pc).to be_nil
    end

    it 'create pay check for single hourly employee with no time cards' do
      emp_id = 2
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      pay_date = Date.new(2001,11,9)
      pt = Payroll::PaydayTransaction.new(pay_date)
      pt.execute
      validate_paycheck(emp_id, 0.0, pay_date, pt)
    end

    it 'create pay check for single hourly employee with time cards' do
      emp_id = 2
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      pay_date = Date.new(2001,11,9)
      tc = TimeCardTransaction.new(pay_date, 2.0, emp_id)
      tc.execute
      pt = Payroll::PaydayTransaction.new(pay_date)
      pt.execute
      validate_paycheck(emp_id, 30.5, pay_date, pt)
    end

    it 'create pay check for single hourly employee overtime with time cards' do
      emp_id = 2
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      pay_date = Date.new(2001,11,9)
      tc = TimeCardTransaction.new(pay_date, 9.0, emp_id)
      tc.execute
      pt = Payroll::PaydayTransaction.new(pay_date)
      pt.execute
      validate_paycheck(emp_id, (8 + 1.5) * 15.25, pay_date, pt)
    end

    it 'create pay check for single hourly employee on wrong date' do
      emp_id = 2
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      pay_date = Date.new(2001,11,8)
      tc = TimeCardTransaction.new(pay_date, 9.0, emp_id)
      tc.execute
      pt = Payroll::PaydayTransaction.new(pay_date)
      pt.execute
      pc = pt.get_paycheck(emp_id)
      expect(pc).to be_nil
    end

    it 'create pay check for single hourly employee overtime with two time cards' do
      emp_id = 2
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      pay_date = Date.new(2001,11,9)
      tc = TimeCardTransaction.new(pay_date, 2.0, emp_id)
      tc.execute
      tc2 = TimeCardTransaction.new(Date.new(2001,11,8), 5.0, emp_id)
      tc2.execute
      pt = Payroll::PaydayTransaction.new(pay_date)
      pt.execute
      validate_paycheck(emp_id, 7 * 15.25, pay_date, pt)
    end

    it 'create pay check for single hourly employee overtime with two time cards spanning two pay periods' do
      emp_id = 2
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      pay_date = Date.new(2001,11,9)
      date_in_previous_pay_period = Date.new(2001,11,2)
      tc = TimeCardTransaction.new(pay_date, 2.0, emp_id)
      tc.execute
      tc2 = TimeCardTransaction.new(date_in_previous_pay_period, 5.0, emp_id)
      tc2.execute
      pt = Payroll::PaydayTransaction.new(pay_date)
      pt.execute
      validate_paycheck(emp_id, 2 * 15.25, pay_date, pt)
    end

    it 'create pay check for single commissioned employee with no sales receipts' do
      emp_id = 3
      t = Payroll::AddCommissionedEmployee.new(emp_id, 'Lance', 'Home', 2500, 3.2)
      t.execute
      pay_date = Date.new(2001,11,9)
      pt = Payroll::PaydayTransaction.new(pay_date)
      pt.execute
      validate_paycheck(emp_id, 2500.00, pay_date, pt)
    end

    it 'create pay check for single commissioned employee with one sales receipts' do
      emp_id = 3
      t = Payroll::AddCommissionedEmployee.new(emp_id, 'Lance', 'Home', 2500, 3.2)
      t.execute
      pay_date = Date.new(2001,11,9)
      srt = SalesReceiptTransaction.new(pay_date, 13000.0, emp_id)
      srt.execute
      pt = Payroll::PaydayTransaction.new(pay_date)
      pt.execute
      validate_paycheck(emp_id, 2500.00 + 3.2 * 13000.0, pay_date, pt)
    end

    it 'create pay check for single commissioned employee with two sales receipts' do
      emp_id = 3
      t = Payroll::AddCommissionedEmployee.new(emp_id, 'Lance', 'Home', 2500, 3.2)
      t.execute
      pay_date = Date.new(2001,11,9)
      srt = SalesReceiptTransaction.new(pay_date, 13000.0, emp_id)
      srt.execute
      srt2 = SalesReceiptTransaction.new(Date.new(2001,11,8), 24000, emp_id)
      srt2.execute
      pt = Payroll::PaydayTransaction.new(pay_date)
      pt.execute
      validate_paycheck(emp_id, 2500.00 + 3.2 * 13000.0 + 3.2 * 24000, pay_date, pt)
    end

    it 'create pay check for single commissioned employee with three sales receipts and multiple pay periods' do
      emp_id = 3
      t = Payroll::AddCommissionedEmployee.new(emp_id, 'Lance', 'Home', 2500, 3.2)
      t.execute
      early_date = Date.new(2001,11,9) # Previous
      # pay
      # period
      pay_date = Date.new(2001,11,23) # Biweekly
      # Friday
      late_date = Date.new(2001,12,7) # Next
      # pay
      # period
      srt = SalesReceiptTransaction.new(pay_date, 13000, emp_id)
      srt.execute
      srt2 = SalesReceiptTransaction.new(early_date, 24000, emp_id)
      srt2.execute
      srt3 = SalesReceiptTransaction.new(late_date, 15000, emp_id)
      srt3.execute
      pt = Payroll::PaydayTransaction.new(pay_date)
      pt.execute
      validate_paycheck(emp_id, 2500.00 + 3.2 * 13000, pay_date, pt)
    end

    it 'create pay check for salaried union members employee' do
      emp_id = 1
      t = Payroll::AddSalariedEmployee.new(emp_id, 'Bob', 'Home', 1000.00)
      t.execute
      member_id = 7734
      cmt = ChangeMemberTransaction.new(emp_id, member_id, 9.42)
      cmt.execute
      pay_date = Date.new(2001,11,30)
      fridays = 5 # Fridays in Nov, 2001.
      pt = Payroll::PaydayTransaction.new(pay_date)
      pt.execute
      pc = pt.get_paycheck(emp_id)
      expect(pc).not_to be_nil
      expect(pc.gross_pay).to eq(1000.0)
      expect(pc.get_field('Disposition')).to eq('Hold')
      expect(pc.deductions).to eq(fridays * 9.42)
      expect(pc.net_pay).to eq(1000.0 - fridays * 9.42)
    end

    it 'create pay check for hourly union members employee' do
      emp_id = 2
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      member_id = 7734
      cmt = ChangeMemberTransaction.new(emp_id, member_id, 9.42)
      cmt.execute
      pay_date = Date.new(2001,11,9)
      tct = TimeCardTransaction.new(pay_date, 8.0, emp_id)
      tct.execute
      pt = Payroll::PaydayTransaction.new(pay_date)
      pt.execute
      pc = pt.get_paycheck(emp_id)
      expect(pc).not_to be_nil
      expect(pc.pay_period_end_date).to eq(pay_date)
      expect(pc.gross_pay).to eq(8 * 15.25)
      expect(pc.get_field('Disposition')).to eq('Hold')
      expect(pc.deductions).to eq(9.42)
      expect(pc.net_pay).to eq(8 * 15.25 - 9.42)
    end

    it 'create pay check for commissioned union members employee' do
      emp_id = 3
      t = Payroll::AddCommissionedEmployee.new(emp_id, 'Lance', 'Home', 2500, 3.2)
      t.execute
      member_id = 7734
      cmt = ChangeMemberTransaction.new(emp_id, member_id, 9.42)
      cmt.execute
      pay_date = Date.new(2001,11,9)
      pt = Payroll::PaydayTransaction.new(pay_date)
      pt.execute
      pc = pt.get_paycheck(emp_id)
      expect(pc).not_to be_nil
      expect(pc.pay_period_end_date).to eq(pay_date)
      expect(pc.gross_pay).to eq(2500.0)
      expect(pc.get_field('Disposition')).to eq('Hold')
      expect(pc.deductions).to eq(2 * 9.42)
      expect(pc.net_pay).to eq(2500.0 - 2 * 9.42)
    end

    it 'create pay check for hourly union members employee with service charge' do
      emp_id = 2
      t = Payroll::AddHourlyEmployee.new(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      member_id = 7734
      cmt = ChangeMemberTransaction.new(emp_id, member_id, 9.42)
      cmt.execute
      pay_date = Date.new(2001,11,9)
      sct = ServiceChargeTransaction.new(member_id, pay_date, 19.42)
      sct.execute
      tct = TimeCardTransaction.new(pay_date, 8.0, emp_id)
      tct.execute
      pt = Payroll::PaydayTransaction.new(pay_date)
      pt.execute
      pc = pt.get_paycheck(emp_id)
      expect(pc).not_to be_nil
      expect(pc.pay_period_end_date).to eq(pay_date)
      expect(pc.gross_pay).to eq(8 * 15.25)
      expect(pc.get_field('Disposition')).to eq('Hold')
      expect(pc.deductions).to eq(9.42 + 19.42)
      expect(pc.net_pay).to eq(8 * 15.25 - (9.42 + 19.42))
    end

  end
end
