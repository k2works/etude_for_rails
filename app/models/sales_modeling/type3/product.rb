# frozen_string_literal: true

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
  belongs_to :product_type_category, class_name: 'SalesModeling::Type3::Category'
  belongs_to :brand_category, class_name: 'SalesModeling::Type3::Category'
  belongs_to :season_category, class_name: 'SalesModeling::Type3::Category'
  belongs_to :year_category, class_name: 'SalesModeling::Type3::Category', optional: true
  has_many :skus, class_name: 'SalesModeling::Type3::Sku', foreign_key: 'sales_modeling_type3_product_id', dependent: :destroy

  def product_code
    @product_code ||= SalesModeling::Type3::ValueObject::ProductCode.new(code)
  end

  def product_code=(product_code)
    self.code = SalesModeling::Type3::ValueObject::ProductCode.new(product_code.code).code
  end

  def year
    @year ||= SalesModeling::Type3::ValueObject::Year.new(year_category.code, year_category.name) unless year_category.nil?
  end

  def season
    @season ||= SalesModeling::Type3::ValueObject::Season.new(season_category.code, season_category.name)
  end

  def season=(season)
    season = SalesModeling::Type3::ValueObject::Season.new(season.code, season.name)
    season = SalesModeling::Type3::Category.where(
      code: season.code,
      name: season.name
    ).first_or_create
    season.save!

    self.season_category = season

    unless season.parent_category.nil?
      year = season.parent_category
      year = SalesModeling::Type3::ValueObject::Season.new(year.code, year.name)
      year = SalesModeling::Type3::Category.where(
        code: year.code,
        name: year.name
      ).first_or_create
      year.save!

      self.year_category = year
    end
  end

  def type
    @type ||= SalesModeling::Type3::ValueObject::ProductType.new(product_type_category.code, product_type_category.name)
  end

  def type=(type)
    type = SalesModeling::Type3::ValueObject::ProductType.new(type.code, type.name)
    type = SalesModeling::Type3::Category.where(
      code: type.code,
      name: type.name
    ).first_or_create
    type.save!

    self.product_type_category = type
  end

  def brand
    @brand ||= SalesModeling::Type3::ValueObject::Brand.new(brand_category.code, brand_category.name)
  end

  def brand=(brand)
    brand = SalesModeling::Type3::ValueObject::Brand.new(brand.code, brand.name)
    brand = SalesModeling::Type3::Category.where(
      code: brand.code,
      name: brand.name
    ).first_or_create
    brand.save!

    self.brand_category = brand
  end
end
