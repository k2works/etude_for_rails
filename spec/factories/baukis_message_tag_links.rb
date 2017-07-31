FactoryGirl.define do
  factory :message_tag_link, class: 'Baukis::MessageTagLink' do
    message
    tag
  end
end
