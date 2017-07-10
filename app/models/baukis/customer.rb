# == Schema Information
#
# Table name: baukis_customers # 顧客
#
#  id               :integer          not null, primary key
#  email            :string(255)      not null              # メールアドレス
#  email_for_index  :string(255)      not null              # 索引用メールアドレス
#  family_name      :string(255)      not null              # 姓
#  given_name       :string(255)      not null              # 名
#  family_name_kana :string(255)      not null              # 姓（カナ）
#  given_name_kana  :string(255)      not null              # 名（カナ）
#  gender           :string(255)                            # 性別
#  birthday         :date                                   # 誕生日
#  hashed_password  :string(255)                            # パスワード
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  baukis_customers_email_for_index  (email_for_index) UNIQUE
#  baukis_customers_nanme_kana       (family_name_kana,given_name_kana)
#

class Baukis::Customer < ApplicationRecord
  has_one :home_address, class_name:'Baukis::HomeAddress', foreign_key: :baukis_customer_id, dependent: :destroy
  has_one :work_address, class_name:'Baukis::WorkAddress', foreign_key: :baukis_customer_id, dependent: :destroy

  before_validation do
    self.email_for_index = email.downcase if email
  end

  validates :gender, inclusion: { in: %w(male feamale), allow_blank: true }
  validates :birthday, date: {
      after: Date.new(1900, 1, 1),
      before: -> (obj) { Date.today },
      allow_blank: true
  }

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end
end
