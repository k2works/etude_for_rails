require 'rails_helper'

RSpec.describe SalesModeling::Type3::Product, type: :model do
  let(:y_2017) { create(:year_category,code:'1',name:'2017') }
  let(:y_2018) { create(:year_category,code:'1',name:'2017') }
  let(:season_2017) { create(:season_category,code:'2',name:'春夏物',parent_category:y_2017) }
  let(:season_2018) { create(:season_category,code:'2',name:'春夏物',parent_category:y_2018) }

  let(:casual) { create(:product_type_category_sub1,code:'3',name:'カジュアル') }
  let(:t_shirt) { create(:product_type_category_sub1,code:'4',name:'Tシャツ',parent_category:casual) }
  let(:jacket) { create(:product_type_category_sub1,code:'5',name:'ジャケット',parent_category:casual) }

  let(:brand_x) { create(:brand_category_sub1,code:'6',name:'X') }
  let(:brand_x1) { create(:brand_category_sub2,code:'7',name:'X1') }
  let(:brand_x2) { create(:brand_category_sub2,code:'8',name:'X2') }
  let(:brand_x3) { create(:brand_category_sub2,code:'9',name:'X3') }

  let(:p0001) { SalesModeling::Type3::ValueObject::ProductCode.new('p0001') }

  let(:product_p0001) { {
      code:p0001.code,
      name:'商品A',
      year_category:y_2017,
      season_category:season_2017,
      product_type_category:t_shirt,
      brand_category:brand_x1
  }}

  describe '#save!' do
    example '品番:P0001・品名:商品A・年度:2017・シーズン:春夏物・商品区分:カジュアル-Tシャツ' do
      product = SalesModeling::Type3::Product.new
      product.code = p0001.code
      product.name = '商品A'
      product.year_category = y_2017
      product.season_category = season_2017
      product.product_type_category = t_shirt
      product.brand_category = brand_x1
      product.save!

      new_product = SalesModeling::Type3::Product.first
      check(new_product,product_p0001)
    end
  end

  private

  def check(new_product,check_product)
    expect(new_product.code).to eq check_product[:code]
    expect(new_product.name).to eq check_product[:name]
    expect(new_product.year_category.name).to eq check_product[:year_category].name
    expect(new_product.season_category.name).to eq check_product[:season_category].name
    expect(new_product.product_type_category.name).to eq check_product[:product_type_category].name
    expect(new_product.brand_category.name).to eq check_product[:brand_category].name
  end
end
