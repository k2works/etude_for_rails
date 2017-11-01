# == Schema Information
#
# Table name: sales_modeling_type2_products # 商品
#
#  id                           :integer          not null, primary key
#  code                         :string(255)                            # 商品コード
#  name                         :string(255)                            # 商品名
#  size_category_id             :integer                                # サイズ
#  color_category_id            :integer                                # 色
#  product_type_category_id     :integer                                # 製品区分
#  unit_purchase_price_amount   :decimal(10, )                          # 仕入単価
#  unit_purchase_price_currency :string(255)                            # 仕入単価通貨
#  unit_sales_price_amount      :decimal(10, )                          # 販売単価
#  unit_sales_price_currency    :string(255)                            # 販売単価通貨
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
# Indexes
#
#  index_color_category_id         (color_category_id)
#  index_product_type_category_id  (product_type_category_id)
#  index_size_category_id          (size_category_id)
#

class SalesModeling::Type2::Product < ApplicationRecord
  belongs_to :size_category, :class_name => 'SalesModeling::Type2::Category'
  belongs_to :color_category, :class_name => 'SalesModeling::Type2::Category'
  belongs_to :product_type_category, :class_name => 'SalesModeling::Type2::Category'

  def product_code
    @product_code ||= SalesModeling::Type2::ProductCode.new(self.code)
  end

  def product_code=(product_code)
    self.code = product_code.code
  end

  def unit_purchase_price
    @unit_purchase_price ||= SalesModeling::Type2::Money.new(self.unit_purchase_price_amount)
  end

  def unit_purchase_price=(money)
    self.unit_purchase_price_amount = money.amount
    self.unit_purchase_price_currency = money.currency
  end

  def unit_sales_price
    @unit_sales_price ||= SalesModeling::Type2::Money.new(self.unit_sales_price_amount)
  end

  def unit_sales_price=(money)
    self.unit_sales_price_amount = money.amount
    self.unit_sales_price_currency = money.currency
  end
end
