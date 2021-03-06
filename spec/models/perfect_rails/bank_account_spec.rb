# == Schema Information
#
# Table name: perfect_rails_bank_accounts
#
#  id                 :integer          not null, primary key
#  credit_card_number :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe PerfectRails::BankAccount, type: :model do
  describe '#credit_card_number' do
    context '保存前' do
      it '暗号化される' do
        bank_account = PerfectRails::BankAccount.new(credit_card_number:'12345')
        expect(bank_account.credit_card_number).to eq ('dencrypted text')
      end
    end

    context '保存後' do
      it '暗号化される' do
        bank_account = PerfectRails::BankAccount.new(credit_card_number:'12345')
        bank_account.save!
        expect(bank_account.credit_card_number).to eq ('dencrypted text')
      end
    end
  end
end
