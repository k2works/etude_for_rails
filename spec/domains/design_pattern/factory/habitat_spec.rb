require 'rails_helper'

describe DesignPattern::Factory::Habitat do
  describe '#simulate_ond_day' do
    it 'simulate one day duck pond' do
      pond = DesignPattern::Factory::Habitat.new(3, 0, DesignPattern::Factory::PondOrganismFactory1.new)
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

    it 'simulate one day frog habitat' do
      pond = DesignPattern::Factory::Habitat.new(3, 0, DesignPattern::Factory::PondOrganismFactory2.new)
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

    it 'simulate one day duck waterlily habitat' do
      pond = DesignPattern::Factory::Habitat.new(2, 4, DesignPattern::Factory::PondOrganismFactory1.new)
      expected = <<-EOS
スイレン 植物0は浮きながら日光を浴びて育ちます。
スイレン 植物1は浮きながら日光を浴びて育ちます。
スイレン 植物2は浮きながら日光を浴びて育ちます。
スイレン 植物3は浮きながら日光を浴びて育ちます。
アヒル 動物0がガーガー鳴いています。
アヒル 動物1がガーガー鳴いています。
アヒル 動物0は食事中です。
アヒル 動物1は食事中です。
アヒル 動物0は静かに眠っています。
アヒル 動物1は静かに眠っています。
      EOS

      expect {pond.simulate_one_day}.to output(expected).to_stdout
    end

    it 'simulate one day tiger tree habitat' do
      pond = DesignPattern::Factory::Habitat.new(1, 4, DesignPattern::Factory::JungleOrganismFactory.new)
      expected = <<-EOS
樹木 植物0が高く育っています。
樹木 植物1が高く育っています。
樹木 植物2が高く育っています。
樹木 植物3が高く育っています。
トラ 動物0はガオーとほえています。
トラ 動物0は食べたいものを何でも食べます。
トラ 動物0は眠たくなったら眠ります。
      EOS

      expect {pond.simulate_one_day}.to output(expected).to_stdout
    end
  end
end