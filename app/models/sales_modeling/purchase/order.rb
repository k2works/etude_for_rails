# == Schema Information
#
# Table name: sales_modeling_purchase_orders # 発注
#
#  id                                   :integer          not null, primary key
#  order_date                           :datetime                               # 発注日
#  scheduled_arrival_date               :datetime                               # 入荷予定日
#  amount                               :decimal(10, )                          # 金額
#  currency                             :string(255)                            # 通貨
#  sales_modeling_purchase_suppliers_id :integer                                # 仕入先
#  order_type_category_code_id          :integer                                # 発注区分
#  created_at                           :datetime         not null
#  updated_at                           :datetime         not null
#
# Indexes
#
#  index_sales_modeling_purchase_order_category_id  (order_type_category_code_id)
#  index_sales_modeling_purchase_order_supplier_id  (sales_modeling_purchase_suppliers_id)
#
# Foreign Keys
#
#  fk_rails_07d9ffe5cc  (sales_modeling_purchase_suppliers_id => sales_modeling_purchase_suppliers.id)
#

class SalesModeling::Purchase::Order < ApplicationRecord
  belongs_to :order_type_category, class_name: 'SalesModeling::Type3::Category'
  belongs_to :sales_modeling_purchase_supplier, :class_name => 'SalesModeling::Purchase::Supplier'
  has_many :sales_modeling_sales_sales_lines, :class_name => 'SalesModeling::Sales::SalesLine'
  has_one :sales_modeling_purchase_warehouse, :class_name => 'SalesModeling::Purchase::Warehouse'
end
