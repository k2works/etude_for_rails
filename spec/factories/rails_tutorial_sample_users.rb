# == Schema Information
#
# Table name: rails_tutorial_sample_users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :rails_tutorial_sample_user, class: 'RailsTutorial::Sample::User' do
    name "MyString"
    emial "MyString"
  end
end
