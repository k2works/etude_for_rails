# == Schema Information
#
# Table name: baukis_staff_members # 職員
#
#  id               :integer          not null, primary key
#  email            :string(255)      not null                 # メールアドレス
#  email_for_index  :string(255)      not null                 # 索引用メールアドレス
#  family_name      :string(255)      not null                 # 姓
#  given_name       :string(255)      not null                 # 名
#  family_name_kana :string(255)      not null                 # 姓（カナ）
#  given_name_kana  :string(255)      not null                 # 名（カナ）
#  hashed_password  :string(255)                               # パスワード
#  start_date       :date             not null                 # 開始日
#  end_date         :date                                      # 終了日
#  suspended        :boolean          default(FALSE), not null # 停止フラグ
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  baukis_staff_members_email      (email_for_index) UNIQUE
#  baukis_staff_members_name_kana  (family_name_kana,given_name_kana)
#

class Baukis::StaffMember < ApplicationRecord
  before_validation do
    self.email_for_index = email.downcase if email
  end

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end
end