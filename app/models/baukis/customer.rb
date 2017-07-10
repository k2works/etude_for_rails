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
#  birth_year       :integer                                # 誕生年
#  birth_month      :integer                                # 誕生月
#  birth_mday       :integer                                # 誕生日
#
# Indexes
#
#  baukis_customers_biarth_day_name_kana         (birth_mday,given_name_kana)
#  baukis_customers_birth_month_day              (birth_month,birth_mday)
#  baukis_customers_birth_year_month_day         (birth_year,birth_month,birth_mday)
#  baukis_customers_email_for_index              (email_for_index) UNIQUE
#  baukis_customers_name_kana                    (given_name_kana)
#  baukis_customers_nanme_kana                   (family_name_kana,given_name_kana)
#  baukis_customers_on_birth_mday_and_furigana   (birth_mday,family_name_kana,given_name_kana)
#  baukis_customers_on_birth_month_and_furigana  (birth_month,family_name_kana,given_name_kana)
#  baukis_customers_on_birth_year_and_furigana   (birth_year,family_name_kana,given_name_kana)
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

  before_save do
    if birthday
      self.birth_year = birthday.year
      self.birth_month = birthday.month
      self.birth_mday = birthday.mday
    end
  end
end
