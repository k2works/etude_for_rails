require 'rails_helper'

describe DesignPattern::Observer::Payroll do
  describe '#update' do
    it 'observe update salary' do
      payroll = DesignPattern::Observer::Payroll.new
      fred = DesignPattern::Observer::Employee.new('Fred', 'Crane Operator', 30000, payroll)

      expected = <<-EOS
Fredのために小切手を切ります！
彼の給料はいま35000です！
      EOS

      expect { fred.salary = 35000 }.to output(expected).to_stdout
    end
  end
end