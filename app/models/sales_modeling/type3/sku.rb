# frozen_string_literal: true

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
  belongs_to :sales_modeling_type3_product, class_name: 'SalesModeling::Type3::Product'
  belongs_to :size_category, class_name: 'SalesModeling::Type3::Category'
  belongs_to :color_category, class_name: 'SalesModeling::Type3::Category'
  belongs_to :sales_modeling_sales_sales_line, class_name: 'SalesModeling::Sales::SalesLine'

  def sku_code
    @sku_code ||= SalesModeling::Code::SkuCode.new(sales_modeling_type3_product.product_code.code, code)
  end

  def sku_code=(sku_code)
    self.code = sku_code.code
  end

  def unit_purchase_price
    @unit_purchase_price ||= SalesModeling::Price::UnitPurchasePrice.new(unit_purchase_price_amount)
  end

  def unit_purchase_price=(money)
    self.unit_purchase_price_amount = money.amount
    self.unit_purchase_price_currency = money.currency
  end

  def unit_sales_price
    @unit_sales_price ||= SalesModeling::Price::UnitSalesPrice.new(unit_sales_price_amount)
  end

  def unit_sales_price=(money)
    self.unit_sales_price_amount = money.amount
    self.unit_sales_price_currency = money.currency
  end

  def color
    @color ||= SalesModeling::Category::Color.new(color_category.code, color_category.name)
  end

  def color=(color)
    color = SalesModeling::Category::Color.new(color.code, color.name)
    self.color_category = SalesModeling::CategoryClassesRepo.select_by_category(color)
  end

  def size
    @size ||= SalesModeling::Category::Size.new(size_category.code, size_category.name)
  end

  def size=(size)
    size = SalesModeling::Category::Size.new(size.code, size.name)
    self.size_category = SalesModeling::CategoryClassesRepo.select_by_category(size)
  end
end
