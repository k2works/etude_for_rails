# == Schema Information
#
# Table name: baukis_staff_members
#
#  id               :integer          not null, primary key
#  email            :string           not null
#  email_for_index  :string           not null
#  family_name      :string           not null
#  given_name       :string           not null
#  family_name_kana :string           not null
#  given_name_kana  :string           not null
#  hashed_password  :string
#  start_date       :date             not null
#  end_date         :date
#  suspended        :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :staff_member, class: 'Baukis::StaffMember' do
    email 'String'
    email_for_index 'String'
    family_name 'String'
    given_name 'String'
    family_name_kana 'String'
    given_name_kana 'String'
    hashed_password 'String'
    start_date Date.today
    end_date Date.today + 1
  end
end
