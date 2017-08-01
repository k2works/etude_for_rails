# == Schema Information
#
# Table name: rails_tutorial_toy_users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :rails_tutorial_toy_user, class: 'RailsTutorial::Toy::User' do
    name "MyString"
    email "MyString"
  end
end
