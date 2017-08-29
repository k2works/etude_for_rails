require 'rails_helper'
require 'madeleine'

describe DesignPattern::Command::Sample::EmployeeManager do
  describe '#add_employee' do
    it 'add employee' do
      store = SnapshotMadeleine.new('employee') { DesignPattern::Command::Sample::EmployeeManager.new }
      tom = DesignPattern::Command::Sample::Employee.new('tom','1001','1 Division Street')
      harry = DesignPattern::Command::Sample::Employee.new('harry','1002','3435 Sunnyside Ave')
      store.execute_command(DesignPattern::Command::Sample::AddEmployee.new(tom))
      store.execute_command(DesignPattern::Command::Sample::AddEmployee.new(harry))

      expected = <<-EOS
Employee: name: tom num: 1001 addr: 1 Division Street
Employee: name: harry num: 1002 addr: 3435 Sunnyside Ave
      EOS

      print = lambda do
        puts(store.execute_command(DesignPattern::Command::Sample::FindEmployee.new('1001')))
        puts(store.execute_command(DesignPattern::Command::Sample::FindEmployee.new('1002')))
      end

      expect { print.call }.to output(expected).to_stdout
    end
  end

  describe '#change_address' do
    it 'change employee address' do
      store = SnapshotMadeleine.new('employee') { DesignPattern::Command::Sample::EmployeeManager.new }
      tom = DesignPattern::Command::Sample::Employee.new('tom','1001','1 Division Street')
      store.execute_command(DesignPattern::Command::Sample::AddEmployee.new(tom))
      store.execute_command(DesignPattern::Command::Sample::ChangeAddress.new('1001','555 Main Street'))

      expected = <<-EOS
Employee: name: tom num: 1001 addr: 555 Main Street
      EOS

      print = lambda do
        puts(store.execute_command(DesignPattern::Command::Sample::FindEmployee.new('1001')))
      end

      expect { print.call }.to output(expected).to_stdout
    end
  end

  describe '#delete_employee' do
    it 'change employee address' do
      store = SnapshotMadeleine.new('employee') { DesignPattern::Command::Sample::EmployeeManager.new }
      tom = DesignPattern::Command::Sample::Employee.new('tom','1001','1 Division Street')
      harry = DesignPattern::Command::Sample::Employee.new('harry','1002','3435 Sunnyside Ave')
      store.execute_command(DesignPattern::Command::Sample::AddEmployee.new(tom))
      store.execute_command(DesignPattern::Command::Sample::AddEmployee.new(harry))
      store.execute_command(DesignPattern::Command::Sample::DeleteEmployee.new('1001'))

      find_tom = store.execute_command(DesignPattern::Command::Sample::FindEmployee.new('1001'))
      find_harry = store.execute_command(DesignPattern::Command::Sample::FindEmployee.new('1002'))

      expect(find_tom).to be_nil
      expect(find_harry).not_to be_nil
    end
  end

end