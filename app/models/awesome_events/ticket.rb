# == Schema Information
#
# Table name: awesome_events_tickets # チケット
#
#  id                      :integer          not null, primary key
#  awesome_events_user_id  :integer                                # ユーザID
#  awesome_events_event_id :integer                                # イベントID
#  comment                 :string(255)                            # コメント
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  by_event_id_user_id                                      (awesome_events_event_id,awesome_events_user_id) UNIQUE
#  by_user_id_event_id                                      (awesome_events_user_id,awesome_events_event_id) UNIQUE
#  index_awesome_events_tickets_on_awesome_events_event_id  (awesome_events_event_id)
#  index_awesome_events_tickets_on_awesome_events_user_id   (awesome_events_user_id)
#
# Foreign Keys
#
#  fk_rails_b50a0cc99e  (awesome_events_event_id => awesome_events_events.id)
#  fk_rails_d14e9716a7  (awesome_events_user_id => awesome_events_users.id)
#

class AwesomeEvents::Ticket < ApplicationRecord
  belongs_to :user, class_name: 'AwesomeEvents::User', foreign_key: :id, optional: true
  belongs_to :event, class_name: 'AwesomeEvents::Event', foreign_key: :id, optional: true

  validates :comment, length: { maximum: 30 }, allow_blank: true
end
