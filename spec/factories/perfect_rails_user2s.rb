# == Schema Information
#
# Table name: perfect_rails_user2s
#
#  id           :integer          not null, primary key
#  name         :string
#  prefecture   :string
#  city         :string
#  house_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :perfect_rails_user2, class: 'PerfectRails::User2' do
    name "MyString"
    prefecture "MyString"
    city "MyString"
    house_number "MyString"
  end
end
