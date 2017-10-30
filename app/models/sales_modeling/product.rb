# == Schema Information
#
# Table name: sales_modeling_products # 商品
#
#  id                                 :integer          not null, primary key
#  code                               :string(255)                            # 商品コード
#  name                               :string(255)                            # 商品名
#  sales_modeling_size_id             :integer
#  sales_modeling_color_id            :integer
#  sales_modeling_product_category_id :integer
#  unit_purchase_price                :decimal(10, )                          # 仕入単価
#  unit_sales_price                   :decimal(10, )                          # 販売単価
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#
# Indexes
#
#  index_sales_modeling_on_color_id             (sales_modeling_color_id)
#  index_sales_modeling_on_product_category_id  (sales_modeling_product_category_id)
#  index_sales_modeling_on_size_id              (sales_modeling_size_id)
#
# Foreign Keys
#
#  fk_rails_3793dc5944  (sales_modeling_product_category_id => sales_modeling_product_categories.id)
#  fk_rails_b57b123249  (sales_modeling_color_id => sales_modeling_colors.id)
#  fk_rails_db80fcf3c4  (sales_modeling_size_id => sales_modeling_sizes.id)
#

class SalesModeling::Product < ApplicationRecord
  belongs_to :sales_modeling_color, :class_name => 'SalesModeling::Color'
  belongs_to :sales_modeling_product_category, :class_name => 'SalesModeling::ProductCategory'
  belongs_to :sales_modeling_size, :class_name => 'SalesModeling::Size'

  def size=(size)
    self.sales_modeling_size = size
  end

  def size
    self.sales_modeling_size
  end

  def color=(color)
    self.sales_modeling_color = color
  end

  def color
    self.sales_modeling_color
  end

  def product_category=(product_category)
    self.sales_modeling_product_category = product_category
  end

  def product_category
    self.sales_modeling_product_category
  end
end
