require 'rails_helper'

describe DesignPattern::Factory::Pond do
  describe '#simulate_ond_day' do
    it 'simulate one day duck pond' do
      pond = DesignPattern::Factory::Pond.new(3, DesignPattern::Factory::Duck,0, DesignPattern::Factory::WaterLily)
      expected = <<-EOS
アヒル 動物0がガーガー鳴いています。
アヒル 動物1がガーガー鳴いています。
アヒル 動物2がガーガー鳴いています。
アヒル 動物0は食事中です。
アヒル 動物1は食事中です。
アヒル 動物2は食事中です。
アヒル 動物0は静かに眠っています。
アヒル 動物1は静かに眠っています。
アヒル 動物2は静かに眠っています。
      EOS

      expect {pond.simulate_one_day}.to output(expected).to_stdout
    end

    it 'simulate one day frog pond' do
      pond = DesignPattern::Factory::Pond.new(3, DesignPattern::Factory::Frog, 0, DesignPattern::Factory::WaterLily)
      expected = <<-EOS
カエル 動物0はゲロゲロと鳴いています。
カエル 動物1はゲロゲロと鳴いています。
カエル 動物2はゲロゲロと鳴いています。
カエル 動物0は食事中です。
カエル 動物1は食事中です。
カエル 動物2は食事中です。
カエル 動物0は眠りません。一晩中ゲロゲロ鳴いています。
カエル 動物1は眠りません。一晩中ゲロゲロ鳴いています。
カエル 動物2は眠りません。一晩中ゲロゲロ鳴いています。
      EOS

      expect {pond.simulate_one_day}.to output(expected).to_stdout
    end

    it 'simulate one day duck waterlily pond' do
      pond = DesignPattern::Factory::Pond.new(1, DesignPattern::Factory::Duck,1, DesignPattern::Factory::WaterLily)
      expected = <<-EOS
スイレン 植物0は浮きながら日光を浴びて育ちます。
アヒル 動物0がガーガー鳴いています。
アヒル 動物0は食事中です。
アヒル 動物0は静かに眠っています。
      EOS

      expect {pond.simulate_one_day}.to output(expected).to_stdout
    end
  end
end