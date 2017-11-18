# == Schema Information
#
# Table name: sales_modeling_purchase_warehouses # 倉庫
#
#  id                               :integer          not null, primary key
#  code                             :string(255)                            # コード
#  name                             :string(255)                            # 名前
#  sales_modeling_purchase_order_id :integer                                # 発注
#  sales_modeling_purchase_stock_id :integer                                # 入庫
#  warehouse_type_category_id       :integer                                # 倉庫区分
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#
# Indexes
#
#  index_sales_modeling_purchase_warehouse_category_id  (warehouse_type_category_id)
#  index_sales_modeling_purchase_warehouses_order_id    (sales_modeling_purchase_order_id)
#  index_sales_modeling_purchase_warehouses_stock_id    (sales_modeling_purchase_stock_id)
#
# Foreign Keys
#
#  fk_rails_61cbc98296  (sales_modeling_purchase_order_id => sales_modeling_purchase_orders.id)
#  fk_rails_fb3074a88f  (sales_modeling_purchase_stock_id => sales_modeling_purchase_stocks.id)
#

class SalesModeling::Purchase::Warehouse < ApplicationRecord
  belongs_to :warehouse_type_category, class_name: 'SalesModeling::Type3::Category'
  belongs_to :sales_modeling_purchase_order, :class_name => 'SalesModeling::Purchase::Order', optional: true
  belongs_to :sales_modeling_purchase_stock, :class_name => 'SalesModeling::Purchase::Stock', optional: true
end
