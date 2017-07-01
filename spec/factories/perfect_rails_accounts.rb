# == Schema Information
#
# Table name: perfect_rails_accounts
#
#  id         :integer          not null, primary key
#  amount     :integer
#  currency   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :account, class: 'PerfectRails::Account' do
    amount 1
    currency "JPY"
  end
end
