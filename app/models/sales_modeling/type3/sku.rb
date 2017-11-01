# == Schema Information
#
# Table name: sales_modeling_type3_skus # ストックキーピングユニット
#
#  id                              :integer          not null, primary key
#  code                            :string(255)                            # SKUコード
#  unit_purchase_price_amount      :decimal(10, )                          # 仕入単価
#  unit_purchase_price_currency    :string(255)                            # 仕入単価通貨
#  unit_sales_price_amount         :decimal(10, )                          # 販売単価
#  unit_sales_price_currency       :string(255)                            # 販売単価通貨
#  sales_modeling_type3_product_id :integer                                # 商品
#  size_category_id                :integer                                # サイズ
#  color_category_id               :integer                                # 色
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#
# Indexes
#
#  index_sales_modeling_type3_on_product_id  (sales_modeling_type3_product_id)
#  index_type3_color_category_id             (color_category_id)
#  index_type3_size_category_id              (size_category_id)
#
# Foreign Keys
#
#  fk_rails_9ce8082daa  (sales_modeling_type3_product_id => sales_modeling_type3_products.id)
#

class SalesModeling::Type3::Sku < ApplicationRecord
  belongs_to :sales_modeling_type3_product, :class_name => 'SalesModeling::Type3::Product'
  belongs_to :size_category, :class_name => 'SalesModeling::Type3::Category'
  belongs_to :color_category, :class_name => 'SalesModeling::Type3::Category'
end
