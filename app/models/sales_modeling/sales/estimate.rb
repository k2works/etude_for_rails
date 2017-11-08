# == Schema Information
#
# Table name: sales_modeling_sales_estimates # 見積
#
#  id                :integer          not null, primary key
#  sales_estimate_id :integer                                # 見積
#  sales_order_id    :integer                                # 注文
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_sales_modeling_sales_estimates_on_sales_estimate_id  (sales_estimate_id)
#  index_sales_modeling_sales_estimates_on_sales_order_id     (sales_order_id)
#

class SalesModeling::Sales::Estimate < ApplicationRecord
  belongs_to :sales_estimate, class_name ;'SalesModeling::Sales::Sale'
  belongs_to :sales_order, class_name ;'SalesModeling::Sales::Sale'
end
