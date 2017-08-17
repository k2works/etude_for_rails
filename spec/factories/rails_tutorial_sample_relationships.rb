FactoryGirl.define do
  factory :rails_tutorial_sample_relationship, class: 'RailsTutorial::Sample::Relationship' do
    follower_id 1
    followed_id 1
  end
end
