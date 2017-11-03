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

  def sku_code
    @sku_code ||= SalesModeling::Type3::ValueObject::SkuCode.new(self.sales_modeling_type3_product.product_code.code,self.code)
  end

  def sku_code=(sku_code)
    self.code = sku_code.code
  end

  def unit_purchase_price
    @unit_purchase_price ||= SalesModeling::Type3::ValueObject::Money.new(self.unit_purchase_price_amount)
  end

  def unit_purchase_price=(money)
    self.unit_purchase_price_amount = money.amount
    self.unit_purchase_price_currency = money.currency
  end

  def unit_sales_price
    @unit_sales_price ||= SalesModeling::Type3::ValueObject::Money.new(self.unit_sales_price_amount)
  end

  def unit_sales_price=(money)
    self.unit_sales_price_amount = money.amount
    self.unit_sales_price_currency = money.currency
  end

  def color
    @color ||= SalesModeling::Type3::ValueObject::Color.new(self.color_category.code, self.color_category.name)
  end

  def color=(color)
    color = SalesModeling::Type3::ValueObject::Color.new(color.code, color.name)
    color = SalesModeling::Type3::Category.where(
        code:color.code,
        name:color.name
    ).first_or_create
    color.save!

    self.color_category = color
  end

  def size
    @size ||= SalesModeling::Type3::ValueObject::Size.new(self.size_category.code, self.size_category.name)
  end

  def size=(size)
    size = SalesModeling::Type3::ValueObject::Size.new(size.code, size.name)
    size = SalesModeling::Type3::Category.where(
        code:size.code,
        name:size.name
    ).first_or_create
    size.save!

    self.size_category = size
  end
end
