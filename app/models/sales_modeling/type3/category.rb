# == Schema Information
#
# Table name: sales_modeling_type3_categories # 分類
#
#  id                                     :integer          not null, primary key
#  code                                   :string(255)                            # コード
#  name                                   :string(255)                            # 分類名
#  sales_modeling_type3_category_class_id :integer
#  parent_category_id                     :integer                                # 親カテゴリ
#  created_at                             :datetime         not null
#  updated_at                             :datetime         not null
#
# Indexes
#
#  index_sales_modeling_type3_categories_on_parent_category_id  (parent_category_id)
#  index_sales_modeling_type3_on_category_class_id              (sales_modeling_type3_category_class_id)
#
# Foreign Keys
#
#  fk_rails_0220975bcb  (sales_modeling_type3_category_class_id => sales_modeling_type3_category_classes.id)
#

class SalesModeling::Type3::Category < ApplicationRecord
  belongs_to :sales_modeling_type3_category_class, :class_name => 'SalesModeling::Type3::CategoryClass'
  belongs_to :parent_category, :class_name => 'SalesModeling::Type3::Category', optional: true
  has_many :categories, :class_name => 'SalesModeling::Type3::Category', :foreign_key => 'parent_category_id'
  has_many :sku_sizes, :class_name => 'SalesModeling::Type3::Sku', :foreign_key => 'size_category_id'
  has_many :sku_colors, :class_name => 'SalesModeling::Type3::Sku', :foreign_key => 'color_category_id'
  has_many :product_type_categories, :class_name => 'SalesModeling::Type3::Product', :foreign_key => 'product_type_category_id'
  has_many :brand_categories, :class_name => 'SalesModeling::Type3::Product', :foreign_key => 'brand_category_id'
  has_many :season_categories, :class_name => 'SalesModeling::Type3::Product', :foreign_key => 'season_category_id'
  has_many :year_categories, :class_name => 'SalesModeling::Type3::Product', :foreign_key => 'year_category_id'
end
