require 'rails_helper'

describe DesignPattern::Factory::Pond do
  describe '#simulate_ond_day' do
    it 'simulate one day pond' do
      pond = DesignPattern::Factory::Pond.new(3)
      expected = <<-EOS
アヒルアヒル0がガーガー鳴いています。
アヒルアヒル1がガーガー鳴いています。
アヒルアヒル2がガーガー鳴いています。
アヒルアヒル0は食事中です。
アヒルアヒル1は食事中です。
アヒルアヒル2は食事中です。
アヒルアヒル0は静かに眠っています。
アヒルアヒル1は静かに眠っています。
アヒルアヒル2は静かに眠っています。
      EOS

      expect {pond.simulate_one_day}.to output(expected).to_stdout
    end
  end
end