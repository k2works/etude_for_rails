# == Schema Information
#
# Table name: sales_modeling_purchase_suppliers # 仕入先
#
#  id                        :integer          not null, primary key
#  code                      :string(255)                            # コード
#  name                      :string(255)                            # 名称
#  prefecture                :string(255)                            # 都道府県
#  city                      :string(255)                            # 市町村
#  house_number              :string(255)                            # 番地
#  telephone_number          :string(255)                            # 電話番号
#  supplier_type_category_id :integer                                # 仕入先区分
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
# Indexes
#
#  index_sales_modeling_purchase_supplier_category_id  (supplier_type_category_id)
#

class SalesModeling::Purchase::Supplier < ApplicationRecord
  belongs_to :supplier_type_category, class_name: 'SalesModeling::Type3::Category'
  has_many :sales_modeling_purchase_orders, :class_name => 'SalesModeling::Purchase::Order'
  has_many :sales_modeling_purchase_stocks, :class_name => 'SalesModeling::Purchase::Stock'
end
