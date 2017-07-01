# == Schema Information
#
# Table name: perfect_rails_credit_cards
#
#  id         :integer          not null, primary key
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :credit_card, class: 'PerfectRails::CreditCard' do
    number "9.99"
  end
end
