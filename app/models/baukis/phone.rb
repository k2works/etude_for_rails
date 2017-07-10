# == Schema Information
#
# Table name: baukis_phones # 電話番号
#
#  id                 :integer          not null, primary key
#  baukis_customer_id :integer          not null              # 顧客への外部キー
#  baukis_address_id  :integer                                # 住所への外部キー
#  number             :string(255)      not null              # 電話番号
#  number_for_index   :string(255)      not null              # 索引用電話番号
#  primary            :boolean          not null              # 優先フラグ
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  baukis_phones_address_id                   (baukis_address_id)
#  baukis_phones_customer_id                  (baukis_customer_id)
#  baukis_phones_number_for_index             (number_for_index)
#  index_baukis_phones_on_baukis_address_id   (baukis_address_id)
#  index_baukis_phones_on_baukis_customer_id  (baukis_customer_id)
#
# Foreign Keys
#
#  fk_rails_4bf4f1bdaa  (baukis_customer_id => baukis_customers.id)
#  fk_rails_e03a947b3d  (baukis_address_id => baukis_addresses.id)
#

class Baukis::Phone < ApplicationRecord
  include Baukis::StringNormalizer

  belongs_to :customer, :class_name => 'Baukis::Customer', foreign_key: :baukis_customer_id, optional: true
  belongs_to :address, :class_name => 'Baukis::Address', foreign_key: :baukis_address_id, optional: true

  before_validation do
    self.number = normalize_as_phone_number(number)
    self.number = number.gsub(/\D/,'') if number
  end

  before_create do
    self.customer = address.customer if address
  end

  validates :number, presence: true, format: { with: /\A\+?\d+(-\d+)*\z/, allow_blank: true }
end
