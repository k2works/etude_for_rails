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
  include Baukis::StringNormalizer

  has_many :events, class_name: 'Baukis::StaffEvent', foreign_key: :baukis_staff_member_id, dependent: :destroy

  before_validation do
    self.email = normalize_as_email(email)
    self.email_for_index = email.downcase if email
    self.family_name = normalize_as_name(family_name)
    self.given_name = normalize_as_name(given_name)
    self.family_name_kana = normalize_as_furigana(family_name_kana)
    self.given_name_kana = normalize_as_furigana(given_name_kana)
  end

  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/

  validates :email, presence: true, email: { allow_blank: true }
  validates :family_name, :given_name, presence: true
  validates :family_name_kana, :given_name_kana, presence: true,
            format: { with: KATAKANA_REGEXP, allow_blank: true }
  validates :start_date, presence: true, date: {
      after_or_equal_to: Date.new(2000,1,1),
      before: -> (obj) { 1.year.from_now.to_date },
      allow_blank: true
  }

  validates :email_for_index, uniqueness: { allow_blank: true }
  after_validation do
    if errors.include?(:email_for_index)
      errors.add(:email, :taken)
      errors.delete(:email_for_index)
    end
  end

  validates :end_date, date: {
      after: :start_date,
      before: -> (obj) { 1.year.from_now.to_date },
      allow_blank: true
  }


  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  def active?
    !suspended? && start_date <= Date.today &&
        (end_date.nil? || end_date > Date.today)
  end
end
