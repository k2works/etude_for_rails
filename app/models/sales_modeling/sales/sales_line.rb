# == Schema Information
#
# Table name: sales_modeling_sales_sales_lines # 売上明細
#
#  id                            :integer          not null, primary key
#  line_number                   :integer                                # 明細番号
#  quantity_amount               :decimal(10, )                          # 数量
#  quantity_unit                 :string(255)                            # 単位
#  unit_sales_price_amount       :decimal(10, )                          # 販売単価
#  unit_sales_price_currency     :string(255)                            # 販売単価通貨
#  sales_price_amount            :decimal(10, )                          # 金額
#  sales_price_currency          :string(255)                            # 通貨
#  sales_modeling_sales_sales_id :integer                                # 売上
#  sales_estimate_id             :integer                                # 売上見積
#  sales_order_id                :integer                                # 売上注文
#  sales_modeling_type3_sku_id   :integer                                # ストックキーピングユニット
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#
# Indexes
#
#  index_sales_modeling_sales_on_sales_estimate_id  (sales_estimate_id)
#  index_sales_modeling_sales_on_sales_id           (sales_modeling_sales_sales_id)
#  index_sales_modeling_sales_on_sales_order_id     (sales_order_id)
#  index_sales_modeling_type3_on_sku_id             (sales_modeling_type3_sku_id)
#
# Foreign Keys
#
#  fk_rails_443527a875  (sales_modeling_sales_sales_id => sales_modeling_sales_sales.id)
#  fk_rails_f5e8ea2b7a  (sales_modeling_type3_sku_id => sales_modeling_type3_skus.id)
#

class SalesModeling::Sales::SalesLine < ApplicationRecord
  belongs_to :sales_modeling_sales, class_name: 'SalesModeling::Sales', optional: true
  belongs_to :sales_estimate, :class_name => 'SalesModeling::Sales::Estimate', optional: true
  belongs_to :sales_order, :class_name => 'SalesModeling::Sales::SalesOrder', optional: true
  belongs_to :sales_modeling_type3_sku, class_name: 'SalesModeling::Type3::Sku', optional: true
end
