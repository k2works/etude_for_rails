# == Schema Information
#
# Table name: sales_modeling_sales_customers # 顧客
#
#  id                        :integer          not null, primary key
#  code                      :string(255)                            # コード
#  name                      :string(255)                            # 名称
#  prefecture                :string(255)                            # 都道府県
#  city                      :string(255)                            # 市町村
#  house_number              :string(255)                            # 番地
#  telephone_number          :string(255)                            # 電話番号
#  customer_type_category_id :integer                                # 顧客区分
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
# Indexes
#
#  index_sales_modeling_salse_customer_category_id  (customer_type_category_id)
#

class SalesModeling::Sales::Customer < ApplicationRecord
  belongs_to :customer_type_category, class_name: 'SalesModeling::Type3::Category'
  has_many :sales_estimates, class_name: 'SalesModeling::Sales::SalesEstimate',foreign_key: :sales_modeling_sales_customer_id
  has_many :sales_sales_orders, class_name: 'SalesModeling::Sales::SalesOrder',foreign_key: :sales_modeling_sales_customer_id
end
