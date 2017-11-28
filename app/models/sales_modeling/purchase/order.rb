# == Schema Information
#
# Table name: sales_modeling_purchase_orders # 発注
#
#  id                                  :integer          not null, primary key
#  order_date                          :datetime                               # 発注日
#  scheduled_arrival_date              :datetime                               # 入荷予定日
#  amount                              :decimal(10, )                          # 金額
#  currency                            :string(255)                            # 通貨
#  sales_modeling_purchase_supplier_id :integer                                # 仕入先
#  order_type_category_id              :integer                                # 発注区分
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#
# Indexes
#
#  index_sales_modeling_purchase_order_category_id  (order_type_category_id)
#  index_sales_modeling_purchase_order_supplier_id  (sales_modeling_purchase_supplier_id)
#
# Foreign Keys
#
#  fk_rails_e65c651d17  (sales_modeling_purchase_supplier_id => sales_modeling_purchase_suppliers.id)
#

class SalesModeling::Purchase::Order < ApplicationRecord
  include SalesModeling::PurchaseDomain
  include ::SalesModeling::Domain::Purchase::Order

  belongs_to :order_type_category, class_name: 'SalesModeling::Type3::Category'
  belongs_to :sales_modeling_purchase_supplier, :class_name => 'SalesModeling::Purchase::Supplier'
  has_many :lines, :class_name => 'SalesModeling::Purchase::OrderLine',  foreign_key: :sales_modeling_purchase_orders_id
  has_one :sales_modeling_purchase_warehouse, :class_name => 'SalesModeling::Purchase::Warehouse'
end
