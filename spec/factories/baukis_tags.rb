FactoryGirl.define do
  factory :tag, class: 'Baukis::Tag' do
    sequence(:value) { |n| "tag_#{n}" }
  end
end
