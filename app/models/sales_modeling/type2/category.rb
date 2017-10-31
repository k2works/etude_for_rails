# == Schema Information
#
# Table name: sales_modeling_type2_categories # 分類
#
#  id                                     :integer          not null, primary key
#  code                                   :string(255)                            # コード
#  name                                   :string(255)                            # 分類名
#  sales_modeling_type2_category_class_id :integer
#  parent_category_id                     :integer                                # 親カテゴリ
#  created_at                             :datetime         not null
#  updated_at                             :datetime         not null
#
# Indexes
#
#  index_sales_modeling_type2_categories_on_parent_category_id  (parent_category_id)
#  index_sales_modeling_type2_on_category_class_id              (sales_modeling_type2_category_class_id)
#
# Foreign Keys
#
#  fk_rails_ab95b4e6fd  (sales_modeling_type2_category_class_id => sales_modeling_type2_category_classes.id)
#

class SalesModeling::Type2::Category < ApplicationRecord
  belongs_to :sales_modeling_type2_category_class, :class_name => 'SalesModeling::Type2::CategoryClass'
  belongs_to :parent_category, :class_name => 'SalesModeling::Type2::Category', optional: true
  has_many :sales_modeling_type2_categories, :class_name => 'SalesModeling::Type2::Category', :foreign_key => 'parent_category_id'
  has_many :sales_modeling_type2_product_sizes, :class_name => 'SalesModeling::Type2::Product', :foreign_key => 'size_id'
  has_many :sales_modeling_type2_product_colors, :class_name => 'SalesModeling::Type2::Product', :foreign_key => 'color_id'
  has_many :sales_modeling_type2_product_product_categories, :class_name => 'SalesModeling::Type2::Product', :foreign_key => 'product_category_id'
end
