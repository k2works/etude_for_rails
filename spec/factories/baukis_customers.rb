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
    family_name '山田'
    given_name '太郎'
    family_name_kana 'ヤマダ'
    given_name_kana  'タロウ'
    password 'pw'
    birthday Date.new(1970,1,1)
    gender 'male'
    association :home_address, strategy: :build
    association :work_address, strategy: :build
  end
end