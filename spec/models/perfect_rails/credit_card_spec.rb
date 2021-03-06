# == Schema Information
#
# Table name: perfect_rails_credit_cards
#
#  id         :integer          not null, primary key
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe PerfectRails::CreditCard, type: :model do
  describe '#number' do
    context 'スペース区切りのとき' do
      it 'スペースは無くなる' do
        card = create(:credit_card, number: '555 234 34')
        card.valid?
        expect(card.number).to eq('55523434')
      end
    end

    context 'ハイフン区切りのとき' do
      it 'ハイフンはなくなる' do
        card = create(:credit_card, number: '5552-3434')
        card.valid?
        expect(card.number).to eq('55523434')
      end
    end
  end
end
