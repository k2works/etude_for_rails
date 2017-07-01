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
  factory :awesome_events_user, class: 'AwesomeEvents::User', aliases: [:owner] do
    provider 'twitter'
    sequence(:uid) { |i| "uid#{i}" }
    sequence(:nickname) { |i| "nickname#{i}" }
    sequence(:image_url) { |i| "http://example.com/image#{i}.jpb"}
  end
end
