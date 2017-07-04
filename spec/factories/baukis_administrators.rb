# == Schema Information
#
# Table name: baukis_administrators
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  email_for_index :string           not null
#  hashed_password :string
#  suspended       :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :administrator, class: 'Baukis::Administrator' do
    email "MyString"
    email_for_index "MyString"
    hashed_password "MyString"
    suspended false
  end
end
