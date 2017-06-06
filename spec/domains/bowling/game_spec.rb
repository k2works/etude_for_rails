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