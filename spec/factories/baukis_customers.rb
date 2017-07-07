# == Schema Information
#
# Table name: baukis_customers
#
#  id               :integer          not null, primary key
#  email            :string           not null
#  email_for_index  :string           not null
#  family_name      :string           not null
#  given_name       :string           not null
#  family_name_kana :string           not null
#  given_name_kana  :string           not null
#  gender           :string
#  birthday         :date
#  hashed_password  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :customer, class: 'Baukis::Customer' do
    sequence(:email) { |n| "memeber#{n}@example.com"}
    family_name 'String'
    given_name 'String'
    family_name_kana 'String'
    given_name_kana  'String'
    gender 'String'
    birthday {60.years.ago.advance(seconds: rand(40.years)).to_date}
    password 'pw'
  end
end
