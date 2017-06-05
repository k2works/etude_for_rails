require 'rails_helper'
include Bowling

describe Bowling::Game do
  describe '#score' do
    context 'when one throw' do
      it 'is scored' do
        f = Game.new
        f.add(5)
        expect(f.score).to eq(5)
      end
    end
  end
end