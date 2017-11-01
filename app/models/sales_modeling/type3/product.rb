# == Schema Information
#
# Table name: sales_modeling_type3_products # 商品
#
#  id                       :integer          not null, primary key
#  code                     :string(255)                            # 商品コード
#  name                     :string(255)                            # 商品名
#  product_type_category_id :integer                                # 製品区分
#  brand_category_id        :integer                                # ブランド
#  season_category_id       :integer                                # シーズン
#  year_category_id         :integer                                # 年度
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_type3_brand_category_id         (brand_category_id)
#  index_type3_product_type_category_id  (product_type_category_id)
#  index_type3_season_category_id        (season_category_id)
#  index_type3_year_category_id          (year_category_id)
#

class SalesModeling::Type3::Product < ApplicationRecord
  belongs_to :product_type_category, :class_name => 'SalesModeling::Type3::Category'
  belongs_to :brand_category, :class_name => 'SalesModeling::Type3::Category'
  belongs_to :season_category, :class_name => 'SalesModeling::Type3::Category'
  belongs_to :year_category, :class_name => 'SalesModeling::Type3::Category'
  has_many :skus, :class_name => 'SalesModeling::Type3::Sku', :foreign_key => 'sales_modeling_type3_product_id'
end
