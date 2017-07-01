# == Schema Information
#
# Table name: perfect_rails_comments
#
#  id           :integer          not null, primary key
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :comment, class: 'PerfectRails::Comment' do
    published_at "2017-07-01 11:00:23"
  end
end
