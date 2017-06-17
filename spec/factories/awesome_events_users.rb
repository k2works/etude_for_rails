# == Schema Information
#
# Table name: awesome_events_users
#
#  id         :integer          not null, primary key
#  provider   :string
#  uid        :string
#  nickname   :string
#  image_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :awesome_events_user, class: 'AwesomeEvents::User' do
    provider "MyString"
    uid "MyString"
    nickname "MyString"
    image_url "MyString"
  end
end
