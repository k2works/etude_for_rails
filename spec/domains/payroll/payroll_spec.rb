require 'rails_helper'
include Payroll
include Payroll::PayrollApplication
include Payroll::PayrollImplementation
include Payroll::TransactionImplementation

describe TransactionImplementation::AddSalariedEmployee do
  def setup_employee
    emp_id = create_salaried_employee
    PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
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

describe TransactionImplementation::AddHourlyEmployee do
  def setup_employee
    emp_id = create_hourly_employee
    PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
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

describe TransactionImplementation::AddCommissionedEmployee do
  def setup_employee
    emp_id = create_commissioned_employee
    PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
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

describe TransactionImplementation::DeleteEmployeeTransaction do
  def setup_employee
    emp_id = create_commissioned_employee
    PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
    emp_id
  end

  describe '#execute' do
    it 'delete record' do
      emp_id = setup_employee
      dt = DeleteEmployeeTransaction.new(emp_id)
      dt.execute
      e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
      expect(e).to be_nil
    end
  end
end

describe TransactionImplementation::TimeCardTransaction do
  describe '#execute' do
    it 'store timecard' do
      emp_id = create_hourly_employee
      tct = TimeCardTransaction.new(20011031,8.0,emp_id)
      tct.execute
      e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
      hc = e.classification
      expect(hc).not_to be_nil
      tc = hc.get_time_card(20011031)
      expect(tc).not_to be_nil
      expect(tc.get_hours).to eq(8.0)
    end
  end
end

describe TransactionImplementation::SalesReceiptTransaction do
  describe '#execute' do
    it 'store sales receipt' do
      emp_id = create_commissioned_employee
      srt = SalesReceiptTransaction.new(20011112, 25000, emp_id)
      srt.execute
      e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
      pc = e.classification
      expect(pc).not_to be_nil
      receipt = pc.get_receipt(20011112)
      expect(receipt).not_to be_nil
      expect(receipt.get_amount).to eq(25000.0)
    end
  end
end

describe TransactionImplementation::ServiceChargeTransaction do
  describe '#execute' do
    it 'store service charge' do
      emp_id = create_hourly_employee
      tct = TimeCardTransaction.new(20011031,8.0,emp_id)
      tct.execute
      e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
      af = PayrollImplementation::UnionAffiliation.new(12.5)
      e.affiliation = af
      member_id = 86
      PayrollDatabase::GlobalDatabase.instance.payroll_db.add_union_member(member_id, e)
      sct = ServiceChargeTransaction.new(member_id, 20011031, 12.95)
      sct.execute
      sc = af.get_service_charge(20011031)
      expect(sc).to eq(12.95)
    end
  end
end

describe TransactionImplementation::ChangeNameTransaction do
  describe '#execute' do
    it 'rename employee' do
      emp_id = create_hourly_employee
      cnt = ChangeNameTransaction.new(emp_id, 'Bob')
      cnt.execute
      e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
      expect(e).not_to be_nil
      expect(e.name).to eq('Bob')
    end
  end
end

describe TransactionImplementation::ChangeAddressTransaction do
  describe '#execute' do
    it 'rename employee' do
      emp_id = create_hourly_employee
      cnt = ChangeAddressTransaction.new(emp_id, 'Second Home')
      cnt.execute
      e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
      expect(e).not_to be_nil
      expect(e.address).to eq('Second Home')
    end
  end
end

describe TransactionImplementation::ChangeHourlyTransaction do
  describe '#execute' do
    it 'change hourly rate' do
      emp_id = create_commissioned_employee
      cht = make_change_hourly_transaction(emp_id, 27.52)
      cht.execute
      e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
      classification = e.classification
      expect(classification).not_to be_nil
      expect(classification).to be_an_instance_of(PayrollImplementation::HourlyClassification)
      expect(classification.get_rate).to eq(27.52)
      schedule = e.schedule
      expect(schedule).to be_an_instance_of(PayrollImplementation::WeeklySchedule)
    end
  end
end

describe TransactionImplementation::ChangeSalariedTransaction do
  describe '#execute' do
    it 'change hourly rate' do
      emp_id = create_commissioned_employee
      cht = make_change_salaried_transaction(emp_id, 25000)
      cht.execute
      e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
      classification = e.classification
      expect(classification).not_to be_nil
      expect(classification).to be_an_instance_of(PayrollImplementation::SalariedClassification)
      expect(classification.get_salary).to eq(25000.0)
      schedule = e.schedule
      expect(schedule).to be_an_instance_of(PayrollImplementation::MonthlySchedule)
    end
  end
end

describe TransactionImplementation::ChangeCommissionedTransaction do
  describe '#execute' do
    it 'change salary and hourly rate' do
      emp_id = create_hourly_employee
      cht = make_change_commissioned_transaction(emp_id, 25000, 4.5)
      cht.execute
      e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
      classification = e.classification
      expect(classification).not_to be_nil
      expect(classification).to be_an_instance_of(CommissionedClassification)
      expect(classification.get_salary).to eq(25000.0)
      expect(classification.get_rate).to eq(4.5)
      schedule = e.schedule
      expect(schedule).to be_an_instance_of(BiweeklySchedule)
    end
  end
end

describe TransactionImplementation::ChangeMailTransaction do
  describe '#execute' do
    it 'change mail send address' do
      emp_id = create_hourly_employee
      cmt = make_change_mail_transaction(emp_id, '4080 El Cerrito Road')
      cmt.execute
      e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
      hold_method = e.hold_method
      expect(hold_method).to be_an_instance_of(MailMethod)
      expect(hold_method.get_address).to eq('4080 El Cerrito Road')
    end
  end
end

describe TransactionImplementation::ChangeDirectTransaction do
  describe '#execute' do
    it 'change direct' do
      emp_id = create_hourly_employee
      cdt = make_change_direct_transaction(emp_id, 'FirstNational', '1058209')
      cdt.execute
      e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
      hold_method = e.hold_method
      expect(hold_method).to be_an_instance_of(DirectMethod)
      expect(hold_method.get_bank).to eq('FirstNational')
      expect(hold_method.get_account).to eq('1058209')
    end
  end
end

describe TransactionImplementation::ChangeHoldTransaction do
  describe '#execute' do
    it 'change payment method' do
      emp_id = create_hourly_employee
      cht = make_change_hold_transaction(emp_id)
      cht.execute
      e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
      payment_method = e.hold_method
      expect(payment_method).not_to be_nil
      expect(payment_method).to be_an_instance_of(HoldMethod)
    end
  end
end

describe TransactionImplementation::ChangeMemberTransaction do
  describe '#execute' do
    it 'change union affiliation' do
      emp_id = 2
      member_id = 7734
      t = make_add_hourly_employee(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      cmt = make_change_member_transaction(emp_id, member_id, 99.42)
      cmt.execute
      e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
      affiliation = e.affiliation
      expect(affiliation).to be_an_instance_of(UnionAffiliation)
      expect(affiliation.get_dues).to eq(99.42)
      member = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_union_member(member_id)
      expect(member).not_to be_nil
      expect(member).to eq(e)
    end
  end
end

describe TransactionImplementation::ChangeUnaffiliatedTransaction do
  describe '#execute' do
    it 'delete union member' do
      emp_id = 2
      member_id = 7734
      t = make_add_hourly_employee(emp_id, 'Bill', 'Home', 15.25)
      t.execute
      cmt = make_change_member_transaction(emp_id, member_id, 99.42)
      cmt.execute
      cuat = make_change_unaffiliated_transaction(emp_id)
      cuat.execute
      e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
      affiliation = e.affiliation
      expect(affiliation).to be_an_instance_of(PayrollDomain::NoAffiliation)
      expect(affiliation.get_service_charge(20011031)).to eq(0)
      member = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_union_member(member_id)
      expect(member).to be_nil
    end
  end
end

describe TransactionImplementation::PaydayTransaction do
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
      emp_id = create_salaried_employee
      pay_date = Date.new(2001,11,30)
      pt = make_payday_transaction(pay_date)
      pt.execute
      validate_paycheck(emp_id, 1000.00, pay_date, pt)
    end

    it 'not create pay check for single salaried employee on wrong date' do
      emp_id = create_salaried_employee
      pay_date = Date.new(2001,11,29)
      pt = make_payday_transaction(pay_date)
      pt.execute
      pc = pt.get_paycheck(emp_id)
      expect(pc).to be_nil
    end

    it 'create pay check for single hourly employee with no time cards' do
      emp_id = create_hourly_employee
      pay_date = Date.new(2001,11,9)
      pt = make_payday_transaction(pay_date)
      pt.execute
      validate_paycheck(emp_id, 0.0, pay_date, pt)
    end

    it 'create pay check for single hourly employee with time cards' do
      emp_id = create_hourly_employee
      pay_date = Date.new(2001,11,9)
      tc = TimeCardTransaction.new(pay_date, 2.0, emp_id)
      tc.execute
      pt = make_payday_transaction(pay_date)
      pt.execute
      validate_paycheck(emp_id, 30.5, pay_date, pt)
    end

    it 'create pay check for single hourly employee overtime with time cards' do
      emp_id = create_hourly_employee
      pay_date = Date.new(2001,11,9)
      tc = TimeCardTransaction.new(pay_date, 9.0, emp_id)
      tc.execute
      pt = make_payday_transaction(pay_date)
      pt.execute
      validate_paycheck(emp_id, (8 + 1.5) * 15.25, pay_date, pt)
    end

    it 'create pay check for single hourly employee on wrong date' do
      emp_id = create_hourly_employee
      pay_date = Date.new(2001,11,8)
      tc = TimeCardTransaction.new(pay_date, 9.0, emp_id)
      tc.execute
      pt = make_payday_transaction(pay_date)
      pt.execute
      pc = pt.get_paycheck(emp_id)
      expect(pc).to be_nil
    end

    it 'create pay check for single hourly employee overtime with two time cards' do
      emp_id = create_hourly_employee
      pay_date = Date.new(2001,11,9)
      tc = TimeCardTransaction.new(pay_date, 2.0, emp_id)
      tc.execute
      tc2 = TimeCardTransaction.new(Date.new(2001,11,8), 5.0, emp_id)
      tc2.execute
      pt = make_payday_transaction(pay_date)
      pt.execute
      validate_paycheck(emp_id, 7 * 15.25, pay_date, pt)
    end

    it 'create pay check for single hourly employee overtime with two time cards spanning two pay periods' do
      emp_id = create_hourly_employee
      pay_date = Date.new(2001,11,9)
      date_in_previous_pay_period = Date.new(2001,11,2)
      tc = TimeCardTransaction.new(pay_date, 2.0, emp_id)
      tc.execute
      tc2 = TimeCardTransaction.new(date_in_previous_pay_period, 5.0, emp_id)
      tc2.execute
      pt = make_payday_transaction(pay_date)
      pt.execute
      validate_paycheck(emp_id, 2 * 15.25, pay_date, pt)
    end

    it 'create pay check for single commissioned employee with no sales receipts' do
      emp_id = create_commissioned_employee
      pay_date = Date.new(2001,11,9)
      pt = make_payday_transaction(pay_date)
      pt.execute
      validate_paycheck(emp_id, 2500.00, pay_date, pt)
    end

    it 'create pay check for single commissioned employee with one sales receipts' do
      emp_id = create_commissioned_employee
      pay_date = Date.new(2001,11,9)
      srt = SalesReceiptTransaction.new(pay_date, 13000.0, emp_id)
      srt.execute
      pt = make_payday_transaction(pay_date)
      pt.execute
      validate_paycheck(emp_id, 2500.00 + 3.2 * 13000.0, pay_date, pt)
    end

    it 'create pay check for single commissioned employee with two sales receipts' do
      emp_id = create_commissioned_employee
      pay_date = Date.new(2001,11,9)
      srt = SalesReceiptTransaction.new(pay_date, 13000.0, emp_id)
      srt.execute
      srt2 = SalesReceiptTransaction.new(Date.new(2001,11,8), 24000, emp_id)
      srt2.execute
      pt = make_payday_transaction(pay_date)
      pt.execute
      validate_paycheck(emp_id, 2500.00 + 3.2 * 13000.0 + 3.2 * 24000, pay_date, pt)
    end

    it 'create pay check for single commissioned employee with three sales receipts and multiple pay periods' do
      emp_id = create_commissioned_employee
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
      pt = make_payday_transaction(pay_date)
      pt.execute
      validate_paycheck(emp_id, 2500.00 + 3.2 * 13000, pay_date, pt)
    end

    it 'create pay check for salaried union members employee' do
      emp_id = create_salaried_employee_member
      pay_date = Date.new(2001,11,30)
      fridays = 5 # Fridays in Nov, 2001.
      pt = make_payday_transaction(pay_date)
      pt.execute
      pc = pt.get_paycheck(emp_id)
      expect(pc).not_to be_nil
      expect(pc.gross_pay).to eq(1000.0)
      expect(pc.get_field('Disposition')).to eq('Hold')
      expect(pc.deductions).to eq(fridays * 9.42)
      expect(pc.net_pay).to eq(1000.0 - fridays * 9.42)
    end

    it 'create pay check for hourly union members employee' do
      emp_id, member_id = create_hourly_employee_member
      pay_date = Date.new(2001,11,9)
      tct = TimeCardTransaction.new(pay_date, 8.0, emp_id)
      tct.execute
      pt = make_payday_transaction(pay_date)
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
      emp_id = create_commissioned_employee_member
      pay_date = Date.new(2001,11,9)
      pt = make_payday_transaction(pay_date)
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
      emp_id, member_id = create_hourly_employee_member
      pay_date = Date.new(2001,11,9)
      sct = ServiceChargeTransaction.new(member_id, pay_date, 19.42)
      sct.execute
      tct = TimeCardTransaction.new(pay_date, 8.0, emp_id)
      tct.execute
      pt = make_payday_transaction(pay_date)
      pt.execute
      pc = pt.get_paycheck(emp_id)
      expect(pc).not_to be_nil
      expect(pc.pay_period_end_date).to eq(pay_date)
      expect(pc.gross_pay).to eq(8 * 15.25)
      expect(pc.get_field('Disposition')).to eq('Hold')
      expect(pc.deductions).to eq(9.42 + 19.42)
      expect(pc.net_pay).to eq(8 * 15.25 - (9.42 + 19.42))
    end

    it 'create pay check for hourly union members employee with service charge and mulitiple pay periods' do
      emp_id, member_id = create_hourly_employee_member
      early_date = Date.new(2001,11,2) # Previous
      # Friday
      pay_date = Date.new(2001,11,9)
      late_date = Date.new(2001, 12, 16) # Next
      # Friday
      sct = ServiceChargeTransaction.new(member_id, pay_date, 19.42)
      sct.execute
      sct_early = ServiceChargeTransaction.new(member_id, early_date, 100.00)
      sct_early.execute
      sct_late = ServiceChargeTransaction.new(member_id, late_date, 200.00)
      sct_late.execute
      tct = TimeCardTransaction.new(pay_date, 8.0, emp_id)
      tct.execute
      pt = make_payday_transaction(pay_date)
      pt.execute
      pc = pt.get_paycheck(emp_id)
      expect(pc).not_to be_nil
      expect(pc.gross_pay).to eq(8 * 15.25)
      expect(pc.get_field('Disposition')).to eq('Hold')
      expect(pc.deductions).to eq(9.42 + 19.42)
      expect(pc.net_pay).to eq(8 * 15.25 - (9.42 + 19.42))
    end
  end
end

describe Payroll::PayrollApplication::PayrollApplication do
  describe '#set_source' do
    it 'parse text file and execute' do
      application = PayrollApplication.new
      application.set_source("spec/domains/payroll/META-INF/Main.txt")
      date = Date.new(2001, 10, 31)
      emp_id = 2
      e = PayrollDatabase::GlobalDatabase.instance.payroll_db.get_employee(emp_id)
      cf = e.classification
      tc = cf.get_time_card(date)
      puts tc.get_hours

      expect(e.name).to eq('Bill')
      expect(e.address).to eq('Home')
      expect(tc.get_date).to eq(date)
      expect(tc.get_hours).to eq(8)
    end
  end
end

def create_salaried_employee
  emp_id = 1
  t = make_add_salaried_employee(emp_id, 'Bob', 'Home', 1000.00)
  t.execute
  emp_id
end

def create_hourly_employee
  emp_id = 2
  t = make_add_hourly_employee(emp_id, 'Bill', 'Home', 15.25)
  t.execute
  emp_id
end

def create_commissioned_employee
  emp_id = 3
  t = make_add_commissioned_employee(emp_id, 'Lance', 'Home', 2500, 3.2)
  t.execute
  emp_id
end

def create_hourly_employee_member
  emp_id = 2
  member_id = 7734
  t = make_add_hourly_employee(emp_id, 'Bill', 'Home', 15.25)
  t.execute
  cmt = make_change_member_transaction(emp_id, member_id, 9.42)
  cmt.execute
  return emp_id, member_id
end

def create_salaried_employee_member
  emp_id = 1
  member_id = 7734
  t = make_add_salaried_employee(emp_id, 'Bob', 'Home', 1000.00)
  t.execute
  cmt = make_change_member_transaction(emp_id, member_id, 9.42)
  cmt.execute
  emp_id
end

def create_commissioned_employee_member
  emp_id = 3
  member_id = 7734
  t = make_add_commissioned_employee(emp_id, 'Lance', 'Home', 2500, 3.2)
  t.execute
  cmt = make_change_member_transaction(emp_id, member_id, 9.42)
  cmt.execute
  emp_id
end

def create_factory
  TransactionImplementation::TransactionFactoryImplementation.new(PayrollImplementation::PayrollFactoryImplementation.new)
end

def make_add_commissioned_employee(emp_id, name, address, salary, commission_rate)
  create_factory.make_add_commissioned_employee(emp_id, name, address, salary, commission_rate)
end

def make_add_hourly_employee(emap_id, name, address, hourly_rate)
  create_factory.make_add_hourly_employee(emap_id, name, address, hourly_rate)
end

def make_add_salaried_employee(emp_id, name, address, salary)
  create_factory.make_add_salaried_employee(emp_id, name, address, salary)
end

def make_change_commissioned_transaction(emp_id, salary, hourly_rate)
  create_factory.make_change_commissioned_transaction(emp_id, salary, hourly_rate)
end

def make_change_direct_transaction(emp_id, bank, account)
  create_factory.make_change_direct_transaction(emp_id, bank, account)
end

def make_change_address_transaction(emp_id, address)
  create_factory.make_change_address_transaction(emp_id, address)
end

def make_change_hold_transaction(emp_id)
  create_factory.make_change_hold_transaction(emp_id)
end

def make_change_hourly_transaction(emp_id, rate)
  create_factory.make_change_hourly_transaction(emp_id, rate)
end

def make_change_mail_transaction(emp_id, rate)
  create_factory.make_change_mail_transaction(emp_id, rate)
end

def make_change_member_transaction(emp_id, memeber_id, dues)
  create_factory.make_change_member_transaction(emp_id, memeber_id, dues)
end

def make_change_name_transaction(emp_id, name)
  create_factory.make_change_name_transaction(emp_id, name)
end

def make_change_salaried_transaction(emp_id, salary)
  create_factory.make_change_salaried_transaction(emp_id, salary)
end

def make_change_unaffiliated_transaction(emp_id)
  create_factory.make_change_unaffiliated_transaction(emp_id)
end

def make_delete_employee_transaction(emp_id)
  create_factory.make_delete_employee_transaction(emp_id)
end

def make_payday_transaction(pay_date)
  create_factory.make_payday_transaction(pay_date)
end

def make_sales_receipt_transaction(sale_date, amount, emp_id)
  create_factory.make_sales_receipt_transaction(sale_date, amount, emp_id)
end

def make_service_charge_transaction(member_id, date, double, amount)
  create_factory.make_service_charge_transaction(member_id, date, double, amount)
end

def make_time_card_transaction(date, hours, emp_id)
  create_factory.make_time_card_transaction(date, hours, emp_id)
end


