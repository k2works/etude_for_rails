FactoryGirl.define do
  factory :bank_account, class: 'PerfectRails::BankAccount' do
    credit_card_number "MyString"
  end
end
