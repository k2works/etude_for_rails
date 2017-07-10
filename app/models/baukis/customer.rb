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
  include Baukis::EmailHolder
  include Baukis::PersonalNameHolder
  include Baukis::PasswordHolder

  has_one :home_address, class_name:'Baukis::HomeAddress', foreign_key: :baukis_customer_id, dependent: :destroy, autosave: true
  has_one :work_address, class_name:'Baukis::WorkAddress', foreign_key: :baukis_customer_id, dependent: :destroy, autosave: true
  has_many :phones, :class_name => 'Baukis::Phone', foreign_key: :baukis_customer_id, dependent: :destroy
  has_many :personal_phones, -> { where(baukis_address_id: nil).order(:id) }, :class_name => 'Baukis::Phone', foreign_key: :baukis_customer_id,autosave: true

  validates :gender, inclusion: { in: %w(male female), allow_blank: true }
  validates :birthday, date: {
      after: Date.new(1900, 1, 1),
      before: -> (obj) { Date.today },
      allow_blank: true
  }
end
