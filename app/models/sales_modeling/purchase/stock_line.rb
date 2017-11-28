# == Schema Information
#
# Table name: sales_modeling_purchase_stock_lines # 入庫明細
#
#  id                                :integer          not null, primary key
#  line_number                       :integer                                # 行番号
#  quantity_amount                   :decimal(10, )                          # 数量
#  quantity_unit                     :string(255)                            # 単位
#  unit_price_amount                 :decimal(10, )                          # 発注単価
#  unit_price_currency               :string(255)                            # 通貨
#  price_amount                      :decimal(10, )                          # 発注金額
#  price_currency                    :string(255)                            # 通貨
#  sales_modeling_purchase_stocks_id :integer                                # 入庫
#  sales_modeling_type3_sku_id       :integer                                # ストックキーピングユニット
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#
# Indexes
#
#  index_sales_modeling_purchase_stock_line_id         (sales_modeling_purchase_stocks_id)
#  index_sales_modeling_purchase_stock_line_on_sku_id  (sales_modeling_type3_sku_id)
#
# Foreign Keys
#
#  fk_rails_29ca9ca1bf  (sales_modeling_purchase_stocks_id => sales_modeling_purchase_stocks.id)
#  fk_rails_d9779e08b9  (sales_modeling_type3_sku_id => sales_modeling_type3_skus.id)
#

class SalesModeling::Purchase::StockLine < ApplicationRecord
  include SalesModeling::PurchaseDomain
  include ::SalesModeling::Domain::Purchase::StockLine

  belongs_to :sales_modeling_purchase_stock, :class_name => 'SalesModeling::Purchase::Stock', optional: true
  belongs_to :sales_modeling_type3_sku, class_name: 'SalesModeling::Type3::Sku', optional: true
end
