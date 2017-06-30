# == Schema Information
#
# Table name: perfect_rails_subscriptions
#
#  id           :integer          not null, primary key
#  signed_up_on :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :subscription, class: 'PerfectRails::Subscription' do
    signed_up_on ""
  end
end
