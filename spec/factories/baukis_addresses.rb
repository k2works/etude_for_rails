# == Schema Information
#
# Table name: baukis_addresses
#
#  id                 :integer          not null, primary key
#  baukis_customer_id :integer          not null
#  type               :string           not null
#  postal_code        :string           not null
#  prefecture         :string           not null
#  city               :string           not null
#  address1           :string           not null
#  address2           :string           not null
#  company_name       :string           default(""), not null
#  division_name      :string           default(""), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :home_address, class: 'Baukis::HomeAddress' do
    postal_code '1000001'
    prefecture '東京都'
    city '千代田区'
    address1 '試験1-1-1'
    address2  ''
  end

  factory :work_address, class: 'Baukis::WorkAddress' do
    company_name 'テスト'
    division_name '開発'
    postal_code '1050000'
    prefecture '東京都'
    city '港区'
    address1 '試験1-1-1'
    address2  ''
  end
end
