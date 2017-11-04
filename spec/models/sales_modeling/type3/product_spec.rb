# frozen_string_literal: true

require 'rails_helper'
include SalesModeling::Type3

RSpec.describe SalesModeling::Type3::Product, type: :model do
  let(:y_2017_value) { ValueObject::Year.new('1', '2017') }
  let(:y_2018_value) { ValueObject::Year.new('1', '2018') }
  let(:y_2017) { create(:year_category, code: y_2017_value.code, name: y_2017_value.name) }
  let(:y_2018) { create(:year_category, code: y_2018_value.code, name: y_2018_value.name) }
  let(:y_2017_season_value) { ValueObject::Season.new('1', '春夏物') }
  let(:y_2018_season_value) { ValueObject::Season.new('2', '秋冬物') }
  let(:season_2017) { create(:season_category, code: y_2017_season_value.code, name: y_2017_season_value.name, parent_category: y_2017) }
  let(:season_2018) { create(:season_category, code: y_2018_season_value.code, name: y_2018_season_value.name, parent_category: y_2018) }

  let(:casual_value) { ValueObject::ProductType.new('1', 'カジュアル') }
  let(:t_shirt_value) { ValueObject::ProductType.new('2', 'Tシャツ') }
  let(:jacket_value) { ValueObject::ProductType.new('3', 'ジャケット') }
  let(:casual) { create(:product_type_category_sub1, code: casual_value.code, name: casual_value.name) }
  let(:t_shirt) { create(:product_type_category_sub1, code: t_shirt_value.code, name: t_shirt_value.name, parent_category: casual) }
  let(:jacket) { create(:product_type_category_sub1, code: jacket_value.code, name: jacket_value.name, parent_category: casual) }

  let(:brand_x_value) { ValueObject::Brand.new('1', 'X') }
  let(:brand_x1_value) { ValueObject::Brand.new('1', 'X1') }
  let(:brand_x2_value) { ValueObject::Brand.new('2', 'X2') }
  let(:brand_x3_value) { ValueObject::Brand.new('3', 'X3') }
  let(:brand_x) { create(:brand_category_sub1, code: brand_x_value.code, name: brand_x_value.name) }
  let(:brand_x1) { create(:brand_category_sub2, code: brand_x1_value.code, name: brand_x1_value.name) }
  let(:brand_x2) { create(:brand_category_sub2, code: brand_x2_value.code, name: brand_x2_value.name) }
  let(:brand_x3) { create(:brand_category_sub2, code: brand_x3_value.code, name: brand_x3_value.name) }

  let(:p0001) { ValueObject::ProductCode.new('1') }
  let(:p0002) { ValueObject::ProductCode.new('2') }
  let(:p0003) { ValueObject::ProductCode.new('3') }

  let(:product) { create(:product_1) }

  let(:product_p0001) do
    {
      code: p0001.code,
      name: '商品A',
      year_category: y_2017,
      season_category: season_2017,
      product_type_category: t_shirt,
      brand_category: brand_x1
    }
  end

  let(:products_repo) { ProductsRepo.new }

  describe '#create' do
    example '品番:p0001・品名:商品A・年度:2017・シーズン:春夏物・商品区分:カジュアル-Tシャツ' do
      product = products_repo.new
      product.product_code = p0001
      product.name = '商品A'
      product.season = season_2017
      product.type = t_shirt
      product.brand = brand_x1
      product.save!

      new_product = products_repo.select_first
      check(new_product, product_p0001)
    end
  end

  describe '#select' do
    example '品番:p0001 品番:p0002 品番:p0003' do
      p0001_product = {
        product_code: p0001,
        name: '商品A',
        season: season_2017,
        type: t_shirt,
        brand: brand_x1
      }
      p0002_product = {
        product_code: p0002,
        name: '商品B',
        season: season_2018,
        type: jacket,
        brand: brand_x2
      }
      p0003_product = {
        product_code: p0003,
        name: '商品C',
        season: season_2018,
        type: t_shirt,
        brand: brand_x3
      }
      products_repo.save(products_repo.new(p0001_product))
      products_repo.save(products_repo.new(p0002_product))
      products_repo.save(products_repo.new(p0003_product))

      expect(products_repo.select_count).to eq 3
      expect(products_repo.select_by_code(p0001.code).count).to eq 1
      expect(products_repo.select_by_season(season_2018).first.season_category).to eq season_2018
      expect(products_repo.select_by_brand(brand_x3).first.brand_category).to eq brand_x3
    end
  end

  describe '#update' do
    example '商品名変更' do
      name = product.name
      products_repo.update(product, name: '商品Z')
      expect(products_repo.select_first.name).not_to eq name
    end

    example '年度・シーズン変更' do
      year = product.year
      season = product.season
      products_repo.update(product, season: season_2018)
      expect(products_repo.select_first.year.name).not_to eq year.name
      expect(products_repo.select_first.season.name).not_to eq season.name
    end

    example 'ブランド変更' do
      brand = product.brand
      products_repo.update(product, brand: brand_x2)
      expect(products_repo.select_first.brand.name).not_to eq brand.name
    end

    example '商品区分変更' do
      type = product.type
      products_repo.update(product, type: jacket)
      expect(products_repo.select_first.type.name).not_to eq type.name
    end
  end

  describe '#delete' do
    example '全件削除' do
      [p0001, p0002, p0003].each do |product_code|
        create(:product_1, code: product_code.code)
      end
      products_repo.delete_all
      expect(products_repo.select_count).not_to eq 3
    end

    example '１件削除' do
      [p0001, p0002, p0003].each do |product_code|
        create(:product_1, code: product_code.code)
      end
      products_repo.delete_by_selected_code(p0001.code)
      expect(products_repo.select_count).to eq 2
    end
  end

  private

  def check(new_product, check_product)
    expect(new_product.code).to eq check_product[:code]
    expect(new_product.name).to eq check_product[:name]
    expect(new_product.year.name).to eq check_product[:year_category].name
    expect(new_product.season.name).to eq check_product[:season_category].name
    expect(new_product.type.name).to eq check_product[:product_type_category].name
    expect(new_product.brand.name).to eq check_product[:brand_category].name
  end
end
