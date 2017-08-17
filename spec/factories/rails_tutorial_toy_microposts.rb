# == Schema Information
#
# Table name: rails_tutorial_toy_microposts
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :rails_tutorial_toy_micropost, class: 'RailsTutorial::Toy::Micropost' do
    content "MyText"
    user_id 1
  end
end
