# == Schema Information
#
# Table name: baukis_staff_events
#
#  id                     :integer          not null, primary key
#  baukis_staff_member_id :integer          not null
#  event_type             :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Baukis::StaffEvent < ApplicationRecord
  belongs_to :member, class_name:'Baukis::StaffMember' ,foreign_key: :baukis_staff_member_id
  alias_attribute :occurred_at, :created_at

  DESCRIPTIONS = {
      logged_in: 'ログイン',
      logged_out: 'ログアウト',
      rejected: 'ログイン拒否'
  }

  def description
    DESCRIPTIONS[event_type.to_sym]
  end
end
