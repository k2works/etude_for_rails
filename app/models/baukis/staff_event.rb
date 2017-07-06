# == Schema Information
#
# Table name: baukis_staff_events # イベント
#
#  id                     :integer          not null, primary key
#  baukis_staff_member_id :integer          not null              # 職員レコードへの外部キー
#  event_type             :string(255)      not null              # イベントタイプ
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  baukis_staff_events_created_at                       (created_at)
#  baukis_staff_events_member_id_created_at             (baukis_staff_member_id,created_at)
#  index_baukis_staff_events_on_baukis_staff_member_id  (baukis_staff_member_id)
#
# Foreign Keys
#
#  fk_rails_680b72fa90  (baukis_staff_member_id => baukis_staff_members.id)
#

class Baukis::StaffEvent < ApplicationRecord
  belongs_to :member, class_name:'Baukis::StaffMember' ,foreign_key: :baukis_staff_member_id
  alias_attribute :occurred_at, :created_at

  DESCRIPTIONS = {
      logged_in: 'ログイン',
      logged_out: '・ログアウト',
      rejected: 'ログイン拒否'
  }

  def description
    DESCRIPTIONS[event_type.to_sym]
  end
end
