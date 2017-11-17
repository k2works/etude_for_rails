# == Schema Information
#
# Table name: sales_modeling_purchase_stocks # 入庫
#
#  id                                   :integer          not null, primary key
#  arrival_date                         :datetime                               # 入庫日付
#  acceptance_date                      :datetime                               # 検収日付
#  sales_modeling_purchase_suppliers_id :integer                                # 仕入先
#  stock_type_category_code_id          :integer                                # 入庫区分
#  created_at                           :datetime         not null
#  updated_at                           :datetime         not null
#
# Indexes
#
#  index_sales_modeling_purchase_stock_category_id  (stock_type_category_code_id)
#  index_sales_modeling_purchase_stock_supplier_id  (sales_modeling_purchase_suppliers_id)
#
# Foreign Keys
#
#  fk_rails_1fa287c287  (sales_modeling_purchase_suppliers_id => sales_modeling_purchase_suppliers.id)
#

class SalesModeling::Purchase::Stock < ApplicationRecord
  belongs_to :stock_type_category, class_name: 'SalesModeling::Type3::Category'
  has_many :sales_modeling_purchase_stock_lines, :class_name => 'SalesModeling::Purchase::StockLine'
  has_one :sales_modeling_purchase_warehouse, :class_name => 'SalesModeling::Purchase::Warehouse'
end
