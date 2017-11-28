# == Schema Information
#
# Table name: sales_modeling_purchase_stocks # 入庫
#
#  id                                  :integer          not null, primary key
#  arrival_date                        :datetime                               # 入庫日付
#  acceptance_date                     :datetime                               # 検収日付
#  sales_modeling_purchase_order_id    :integer                                # 発注
#  sales_modeling_purchase_supplier_id :integer                                # 仕入先
#  stock_type_category_id              :integer                                # 入庫区分
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#
# Indexes
#
#  index_sales_modeling_purchase_stock_category_id  (stock_type_category_id)
#  index_sales_modeling_purchase_stock_order_id     (sales_modeling_purchase_order_id)
#  index_sales_modeling_purchase_stock_supplier_id  (sales_modeling_purchase_supplier_id)
#
# Foreign Keys
#
#  fk_rails_7d374c4035  (sales_modeling_purchase_order_id => sales_modeling_purchase_orders.id)
#  fk_rails_b08a0e692d  (sales_modeling_purchase_supplier_id => sales_modeling_purchase_suppliers.id)
#

class SalesModeling::Purchase::Stock < ApplicationRecord
  include SalesModeling::PurchaseDomain
  include ::SalesModeling::Domain::Purchase::Stock

  belongs_to :stock_type_category, class_name: 'SalesModeling::Type3::Category'
  belongs_to :sales_modeling_purchase_supplier, :class_name => 'SalesModeling::Purchase::Supplier'
  belongs_to :sales_modeling_purchase_order, :class_name => 'SalesModeling::Purchase::Order'
  has_many :lines, :class_name => 'SalesModeling::Purchase::StockLine', foreign_key: :sales_modeling_purchase_stocks_id
  has_one :warehouse, :class_name => 'SalesModeling::Purchase::Warehouse', foreign_key: :sales_modeling_purchase_stock_id
end
