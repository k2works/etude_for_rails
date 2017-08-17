# == Schema Information
#
# Table name: baukis_phones
#
#  id                 :integer          not null, primary key
#  baukis_customer_id :integer          not null
#  baukis_address_id  :integer
#  number             :string           not null
#  number_for_index   :string           not null
#  primary            :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  last_four_digits   :string
#

FactoryGirl.define do
  factory :phone, class: 'Baukis::Phone' do
    number '000-000-000'
    customer
  end
end
