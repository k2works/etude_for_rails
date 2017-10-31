# == Schema Information
#
# Table name: sales_modeling_type1_products # 商品
#
#  id                                       :integer          not null, primary key
#  code                                     :string(255)                            # 商品コード
#  name                                     :string(255)                            # 商品名
#  sales_modeling_type1_size_id             :integer
#  sales_modeling_type1_color_id            :integer
#  sales_modeling_type1_product_category_id :integer
#  unit_purchase_price_amount               :decimal(10, )                          # 仕入単価
#  unit_purchase_price_currency             :string(255)                            # 仕入単価通貨
#  unit_sales_price_amount                  :decimal(10, )                          # 販売単価
#  unit_sales_price_currency                :string(255)                            # 販売単価通貨
#  created_at                               :datetime         not null
#  updated_at                               :datetime         not null
#
# Indexes
#
#  index_sales_modeling_type1_on_color_id             (sales_modeling_type1_color_id)
#  index_sales_modeling_type1_on_product_category_id  (sales_modeling_type1_product_category_id)
#  index_sales_modeling_type1_on_size_id              (sales_modeling_type1_size_id)
#
# Foreign Keys
#
#  fk_rails_a430deaab8  (sales_modeling_type1_size_id => sales_modeling_type1_sizes.id)
#  fk_rails_c635ddefc9  (sales_modeling_type1_color_id => sales_modeling_type1_colors.id)
#  fk_rails_c9d507139e  (sales_modeling_type1_product_category_id => sales_modeling_type1_product_categories.id)
#

class SalesModeling::Type1::Product < ApplicationRecord
  belongs_to :sales_modeling_type1_color, :class_name => 'SalesModeling::Type1::Color'
  belongs_to :sales_modeling_type1_product_category, :class_name => 'SalesModeling::Type1::ProductCategory'
  belongs_to :sales_modeling_type1_size, :class_name => 'SalesModeling::Type1::Size'

  def jan
    @jan ||= SalesModeling::JANCode.new(self.code)
  end

  def jan=(jan)
    self.code = jan.code
    @jan = jan
  end

  def size=(size)
    self.sales_modeling_type1_size = size
  end

  def size
    self.sales_modeling_type1_size
  end

  def color=(color)
    self.sales_modeling_type1_color = color
  end

  def color
    self.sales_modeling_type1_color
  end

  def product_category=(product_category)
    self.sales_modeling_type1_product_category = product_category
  end

  def product_category
    self.sales_modeling_type1_product_category
  end

  def unit_purchase_price
    @unit_purchase_price ||= SalesModeling::Money.new(self.unit_purchase_price_amount)
  end

  def unit_purchase_price=(money)
    self.unit_purchase_price_amount = money.amount
    self.unit_purchase_price_currency = money.currency
  end

  def unit_sales_price
    @unit_sales_price ||= SalesModeling::Money.new(self.unit_sales_price_amount)
  end

  def unit_sales_price=(money)
    self.unit_sales_price_amount = money.amount
    self.unit_sales_price_currency = money.currency
  end
end
