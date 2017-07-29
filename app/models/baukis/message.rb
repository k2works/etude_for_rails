# == Schema Information
#
# Table name: baukis_messages # 問い合わせ
#
#  id              :integer          not null, primary key
#  customer_id     :integer          not null                 # 顧客への外部キー
#  staff_member_id :integer                                   # 職員への外部キー
#  root_id         :integer                                   # Messageへの外部キー
#  parent_id       :integer                                   # Messageへの外部キー
#  type            :string(255)      not null                 # 継承カラム
#  status          :string(255)      default("new"), not null # 状態（職員向け）
#  subject         :string(255)      not null                 # 件名
#  body            :text(65535)                               # 本文
#  remarks         :text(65535)                               # 備考（職員向け）
#  discarded       :boolean          default(FALSE), not null # 顧客側の削除フラグ
#  deleted         :boolean          default(FALSE), not null # 職員側の削除フラグ
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  baukis_messages_custoemr_id_deleted_status_created_at  (customer_id,deleted,status,created_at)
#  baukis_messages_customer_id                            (customer_id)
#  baukis_messages_customer_id_deleted_created_at         (customer_id,deleted,created_at)
#  baukis_messages_customer_id_discarded_created_at       (customer_id,discarded,created_at)
#  baukis_messages_root_id_deleted_created_at             (root_id,deleted,created_at)
#  baukis_messages_staff_member_id                        (staff_member_id)
#  baukis_messages_type_customer_id                       (type,customer_id)
#  baukis_messages_type_staff_member_id                   (type,staff_member_id)
#  index_baukis_messages_on_customer_id                   (customer_id)
#  index_baukis_messages_on_staff_member_id               (staff_member_id)
#

class Baukis::Message < ApplicationRecord
  belongs_to :customer, :class_name => 'Baukis::Customer'
  belongs_to :staff_member, :class_name => 'Baukis::StaffMember', optional: true
  belongs_to :root, :class_name => 'Baukis::Message', foreign_key: 'root_id', optional: true
  belongs_to :parent, :class_name => 'Baukis::Message', foreign_key: 'parent_id', optional: true
  has_many :children, :class_name => 'Baukis::Message', foreign_key: 'parent_id'

  validates :subject, :body, presence: true
  validates :subject, length: { maximum: 80, allow_blank: true }
  validates :body, length: { maximum: 800, allow_blank: true }

  before_create do
    if parent
      self.customer = parent.customer
      self.root = parent.root || parent
    end
  end

  default_scope { order(created_at: :desc) }
end
