# == Schema Information
#
# Table name: awesome_events_tickets
#
#  id                      :integer          not null, primary key
#  awesome_events_user_id  :integer
#  awesome_events_event_id :integer
#  comment                 :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

FactoryGirl.define do
  factory :awesome_events_ticket, class: 'AwesomeEvents::Ticket' do
    user nil
    event nil
    comment "MyString"
  end
end
