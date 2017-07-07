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
    customer
    postal_code 'String'
    prefecture 'String'
    city 'String'
    address1 'String'
    address2  'String'
  end

  factory :work_address, class: 'Baukis::WorkAddress' do
    customer
    postal_code 'String'
    prefecture 'String'
    city 'String'
    address1 'String'
    address2  'String'
  end
end
