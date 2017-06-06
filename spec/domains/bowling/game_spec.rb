require 'rails_helper'
include Bowling

describe Bowling::Game do
  let(:g) { Game.new }

  describe '#score' do
    context 'when two throws' do
      it 'is scored' do
        g.add(5)
        g.add(4)
        expect(g.score).to eq(9)
      end
    end

    context 'when spare' do
      it 'is scored' do
        g.add(3)
        g.add(7)
        g.add(3)
        g.add(2)
        expect(g.score).to eq(18)
      end
    end

    context 'when strike' do
      it 'is scored' do
        g.add(10)
        g.add(3)
        g.add(6)
        expect(g.score).to eq(28)
      end
    end

    context 'when perfect game' do
      it 'is scored' do
        12.times do
          g.add(10)
        end
        expect(g.score).to eq(300)
      end
    end

    context 'when 10th frame' do
      it 'is scored' do
        9.times do
          g.add(0)
          g.add(0)
        end
        g.add(2)
        g.add(8)  # 10番目のフレームのスペア
        g.add(10) # 配列の最後にストライク
        expect(g.score).to eq(20)
      end
    end

    context 'when playing one game' do
      it 'is scored' do
        g.add(1)
        g.add(4)
        g.add(4)
        g.add(5)
        g.add(6)
        g.add(4)
        g.add(5)
        g.add(5)
        g.add(10)
        g.add(0)
        g.add(1)
        g.add(7)
        g.add(3)
        g.add(6)
        g.add(4)
        g.add(10)
        g.add(2)
        g.add(8)
        g.add(6)
        expect(g.score).to eq(133)
      end
    end
  end

  describe '#score_for_frame' do
    context 'when four throws' do
      it 'is scored by frame' do
        g.add(5)
        g.add(4)
        g.add(7)
        g.add(2)
        expect(g.score_for_frame(1)).to eq(9)
        expect(g.score_for_frame(2)).to eq(18)
      end
    end

    context 'when spare' do
      it 'is scored by frame' do
        g.add(3)
        g.add(7)
        g.add(3)
        g.add(2)
        expect(g.score_for_frame(1)).to eq(13)
        expect(g.score_for_frame(2)).to eq(18)
      end
    end

    context 'when strike' do
      it 'is scored by frame' do
        g.add(10)
        g.add(3)
        g.add(6)
        expect(g.score_for_frame(1)).to eq(19)
      end
    end

    context 'when perfect game' do
      it 'current frame is' do
        12.times do
          g.add(10)
        end
        expect(g.get_current_frame).to eq(11)
      end
    end
  end

  describe '#get_current_frame' do
    context 'when one throw' do
      it 'is first frame' do
        g.add(5)
        expect(g.get_current_frame).to eq(1)
      end
    end

    context 'when two throws' do
      it 'is second frame' do
        g.add(5)
        g.add(4)
        expect(g.get_current_frame).to eq(2)
      end
    end

    context 'when spare' do
      it 'is third frame' do
        g.add(3)
        g.add(7)
        g.add(3)
        expect(g.get_current_frame).to eq(2)
      end

      it 'is third frame' do
        g.add(3)
        g.add(7)
        g.add(3)
        g.add(2)
        expect(g.get_current_frame).to eq(3)
      end
    end
  end
end