# == Schema Information
#
# Table name: awesome_events_events # イベント
#
#  id         :integer          not null, primary key
#  owner_id   :integer                                # イベントを作成したユーザのID
#  name       :string(255)      not null              # イベントの名前
#  place      :string(255)      not null              # イベントの開催場所
#  start_time :datetime         not null              # イベント開始時間
#  end_time   :datetime         not null              # イベント終了時間
#  content    :text(65535)      not null              # イベントの詳細
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AwesomeEvents::Event < ApplicationRecord
  has_many :tickets, class_name: 'AwesomeEvents::Ticket', foreign_key: :awesome_events_event_id, dependent: :destroy
  belongs_to :owner, class_name: 'AwesomeEvents::User', foreign_key: :id, optional: true

  validates :name, length: { maximum: 50 }, presence: true
  validates :place, length: { maximum: 100 }, presence: true
  validates :content, length: { maximum: 2000 }, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_should_be_before_end_time

  def created_by?(user)
    return false unless user
    owner_id == user.id
  end

  private

  def start_time_should_be_before_end_time
    return unless start_time && end_time

    if start_time >= end_time
      errors.add(:start_time, 'は終了時間よりも前に設定してください')
    end
  end
end
