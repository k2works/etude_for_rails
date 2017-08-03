# == Schema Information
#
# Table name: baukis_addresses # 住所
#
#  id                 :integer          not null, primary key
#  baukis_customer_id :integer          not null              # 顧客への外部キー
#  type               :string(255)      not null              # 継承カラム
#  postal_code        :string(255)      not null              # 郵便番号
#  prefecture         :string(255)      not null              # 都道府県
#  city               :string(255)      not null              # 市区町村
#  address1           :string(255)      not null              # 町域、番地等
#  address2           :string(255)      not null              # 建物名、部屋番号等
#  company_name       :string(255)      default(""), not null # 会社名
#  division_name      :string(255)      default(""), not null # 部署名
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  baukis_addresses_city                         (city)
#  baukis_addresses_customer_id                  (baukis_customer_id)
#  baukis_addresses_postal_code                  (postal_code)
#  baukis_addresses_prefecture_city              (prefecture,city)
#  baukis_addresses_type_city                    (type,city)
#  baukis_addresses_type_customer_id             (type,baukis_customer_id) UNIQUE
#  baukis_addresses_type_prefecture_city         (type,prefecture,city)
#  index_baukis_addresses_on_baukis_customer_id  (baukis_customer_id)
#
# Foreign Keys
#
#  fk_rails_1cf2156925  (baukis_customer_id => baukis_customers.id)
#

class Baukis::WorkAddress < Baukis::Address
  before_validation do
    self.company_name = normalize_as_name(company_name)
    self.division_name = normalize_as_name(division_name)
  end

  validates :company_name, presence: true
end

