# == Schema Information
#
# Table name: perfect_rails_bank_accounts
#
#  id                 :integer          not null, primary key
#  credit_card_number :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :bank_account, class: 'PerfectRails::BankAccount' do
    credit_card_number "MyString"
  end
end
