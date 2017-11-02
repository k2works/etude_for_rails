require 'rails_helper'

RSpec.describe SalesModeling::Type3::Product, type: :model do
  let(:y_2017_value) { SalesModeling::Type3::ValueObject::Year.new('1','2017')}
  let(:y_2018_value) { SalesModeling::Type3::ValueObject::Year.new('1','2018')}
  let(:y_2017) { create(:year_category,code:y_2017_value.code,name:y_2017_value.name) }
  let(:y_2018) { create(:year_category,code:y_2018_value.code,name:y_2018_value.name) }
  let(:y_2017_season_value) { SalesModeling::Type3::ValueObject::Season.new('1','春夏物')}
  let(:y_2018_season_value) { SalesModeling::Type3::ValueObject::Season.new('2','春夏物')}
  let(:season_2017) { create(:season_category,code:y_2017_season_value.code,name:y_2017_season_value.name,parent_category:y_2017) }
  let(:season_2018) { create(:season_category,code:y_2018_season_value.code,name:y_2018_season_value.name,parent_category:y_2018) }

  let(:casual_value) {SalesModeling::Type3::ValueObject::ProductType.new('1','カジュアル')}
  let(:t_shirt_value) {SalesModeling::Type3::ValueObject::ProductType.new('2','Tシャツ')}
  let(:jacket_value) {SalesModeling::Type3::ValueObject::ProductType.new('3','ジャケット')}
  let(:casual) { create(:product_type_category_sub1,code:casual_value.code,name:casual_value.name) }
  let(:t_shirt) { create(:product_type_category_sub1,code:t_shirt_value.code,name:t_shirt_value.name,parent_category:casual) }
  let(:jacket) { create(:product_type_category_sub1,code:jacket_value.code,name:jacket_value.name,parent_category:casual) }

  let(:brand_x_value) {SalesModeling::Type3::ValueObject::Brand.new('1','X')}
  let(:brand_x1_value) {SalesModeling::Type3::ValueObject::Brand.new('1','X1')}
  let(:brand_x2_value) {SalesModeling::Type3::ValueObject::Brand.new('2','X2')}
  let(:brand_x3_value) {SalesModeling::Type3::ValueObject::Brand.new('3','X3')}
  let(:brand_x) { create(:brand_category_sub1,code:brand_x_value.code,name:brand_x_value.name) }
  let(:brand_x1) { create(:brand_category_sub2,code:brand_x1_value.code,name:brand_x1_value.name) }
  let(:brand_x2) { create(:brand_category_sub2,code:brand_x2_value.code,name:brand_x2_value.name) }
  let(:brand_x3) { create(:brand_category_sub2,code:brand_x3_value.code,name:brand_x3_value.name) }

  let(:p0001) { SalesModeling::Type3::ValueObject::ProductCode.new('1') }
  let(:p0002) { SalesModeling::Type3::ValueObject::ProductCode.new('2') }
  let(:p0003) { SalesModeling::Type3::ValueObject::ProductCode.new('3') }

  let(:product_p0001) { {
      code:p0001.code,
      name:'商品A',
      year_category:y_2017,
      season_category:season_2017,
      product_type_category:t_shirt,
      brand_category:brand_x1
  }}

  describe '#create' do
    example '品番:p0001・品名:商品A・年度:2017・シーズン:春夏物・商品区分:カジュアル-Tシャツ' do
      product = SalesModeling::Type3::Product.new
      product.product_code = p0001
      product.name = '商品A'
      product.season = season_2017
      product.type = t_shirt
      product.brand = brand_x1
      product.save!

      new_product = SalesModeling::Type3::Product.first
      check(new_product,product_p0001)
    end
  end

  describe '#select' do
    example '品番:p0001 品番:p0002 品番:p0003' do
      SalesModeling::Type3::Product.new({
                                            product_code:p0001,
                                            name:'商品A',
                                            season:season_2017,
                                            type:t_shirt,
                                            brand:brand_x1
                                        }).save!

      SalesModeling::Type3::Product.new({
                                            product_code:p0002,
                                            name:'商品B',
                                            season:season_2018,
                                            type:jacket,
                                            brand:brand_x2
                                        }).save!

      SalesModeling::Type3::Product.new({
                                            product_code:p0003,
                                            name:'商品C',
                                            season:season_2018,
                                            type:t_shirt,
                                            brand:brand_x3
                                        }).save!

      expect(SalesModeling::Type3::Product.count).to eq 3
      expect(SalesModeling::Type3::Product.where(code:p0001.code).count).to eq 1
      expect(SalesModeling::Type3::Product.where(season_category_id: season_2018.id).first.season_category).to eq season_2018
      expect(SalesModeling::Type3::Product.where(brand_category_id: brand_x3.id).first.brand_category).to eq brand_x3
    end
  end

  private

  def check(new_product,check_product)
    expect(new_product.code).to eq check_product[:code]
    expect(new_product.name).to eq check_product[:name]
    expect(new_product.year.name).to eq check_product[:year_category].name
    expect(new_product.season.name).to eq check_product[:season_category].name
    expect(new_product.type.name).to eq check_product[:product_type_category].name
    expect(new_product.brand.name).to eq check_product[:brand_category].name
  end
end
