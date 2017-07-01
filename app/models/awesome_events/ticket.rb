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

class AwesomeEvents::Ticket < ApplicationRecord
  belongs_to :user, class_name: 'AwesomeEvents::User', foreign_key: :id, optional: true
  belongs_to :event, class_name: 'AwesomeEvents::Event', foreign_key: :id, optional: true

  validates :comment, length: { maximum: 30 }, allow_blank: true
end
