require 'rails_helper'

RSpec.describe AwesomeEvents::Event, type: :model do
  describe '#name' do
    context '空白のとき' do
      let(:event) { AwesomeEvents::Event.new(name: '') }

      it 'valida でないこと' do
        event.valid?
        expect(event.errors[:name]).to be_present
      end
    end
  end

end
