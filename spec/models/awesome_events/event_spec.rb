require 'rails_helper'

RSpec.describe AwesomeEvents::Event, type: :model do
  describe '#name' do
    context '#name' do
      context 'nilのとき' do
        let(:event) { AwesomeEvents::Event.new(name: nil) }

        it 'validでないこと' do
          event.valid?
          expect(event.errors[:name]).to be_present
        end
      end
    end

    context '空白のとき' do
      let(:event) { AwesomeEvents::Event.new(name: '') }

      it 'valida でないこと' do
        event.valid?
        expect(event.errors[:name]).to be_present
      end
    end

    context 'Rails勉強会の時' do
      let(:event) { AwesomeEvents::Event.new(name: 'Rails勉強会') }

      it 'validであること' do
        event.valid?
        expect(event.errors[:name]).to be_blank
      end
    end

    context '50文字のとき' do
      let(:event) { AwesomeEvents::Event.new(name: 'a' * 50) }

      it 'validであること' do
        event.valid?
        expect(event.errors[:name]).to be_blank
      end

      context '51文字のとき' do
        let(:event) { AwesomeEvents::Event.new(name: 'a' * 51) }

        it 'validでないこと' do
          event.valid?
          expect(event.errors[:name]).to be_present
        end
      end
    end
  end

end
