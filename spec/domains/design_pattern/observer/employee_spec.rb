require 'rails_helper'

describe DesignPattern::Observer::Employee do
  describe '#salary' do
    it 'observe payroll' do
      fred = DesignPattern::Observer::Employee.new('Fred', 'Crane Operator', 30000)
      payroll = DesignPattern::Observer::Payroll.new
      fred.add_observer( payroll )

      expected = <<-EOS
Fredのために小切手を切ります！
彼の給料はいま35000です！
      EOS

      expect { fred.salary = 35000 }.to output(expected).to_stdout
    end

    it 'observe payroll and tax man' do
      fred = DesignPattern::Observer::Employee.new('Fred', 'Crane Operator', 30000)
      payroll = DesignPattern::Observer::Payroll.new
      fred.add_observer( payroll )
      tax_man = DesignPattern::Observer::TaxMan.new
      fred.add_observer( tax_man )

      expected = <<-EOS
Fredのために小切手を切ります！
彼の給料はいま90000です！
Fredに新しい税金の請求書を送ります！
      EOS

      expect { fred.salary = 90000 }.to output(expected).to_stdout
    end    
  end
end

describe DesignPattern::Observer::Employee2 do
  describe '#salary' do
    it 'observe payroll' do
      fred = DesignPattern::Observer::Employee2.new('Fred', 'Crane Operator', 30000)
      payroll = DesignPattern::Observer::Payroll.new
      fred.add_observer( payroll )

      expected = <<-EOS
Fredのために小切手を切ります！
彼の給料はいま35000です！
      EOS

      expect { fred.salary = 35000 }.to output(expected).to_stdout
    end

    it 'observe payroll and tax man' do
      fred = DesignPattern::Observer::Employee2.new('Fred', 'Crane Operator', 30000)
      payroll = DesignPattern::Observer::Payroll.new
      fred.add_observer( payroll )
      tax_man = DesignPattern::Observer::TaxMan.new
      fred.add_observer( tax_man )

      expected = <<-EOS
Fredのために小切手を切ります！
彼の給料はいま90000です！
Fredに新しい税金の請求書を送ります！
      EOS

      expect { fred.salary = 90000 }.to output(expected).to_stdout
    end
  end
end

describe DesignPattern::Observer::Employee3 do
  describe '#salary' do
    it 'observe payroll' do
      fred = DesignPattern::Observer::Employee3.new('Fred', 'Crane Operator', 30000)
      fred.add_observer do |change_employee|
        puts("Cut a new check for #{change_employee.name}!")
        puts("His salary is now #{change_employee.salary}!")
      end

      expected = <<-EOS
Cut a new check for Fred!
His salary is now 35000!
      EOS

      expect { fred.salary = 35000 }.to output(expected).to_stdout
    end
  end
end