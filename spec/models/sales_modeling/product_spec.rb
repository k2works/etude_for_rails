require 'rails_helper'

RSpec.describe SalesModeling::Product, type: :model do
  let(:s) { create(:sales_modeling_size,name:'S') }
  let(:m) { create(:sales_modeling_size,name:'M') }
  let(:l) { create(:sales_modeling_size,name:'L') }

  let(:red) { create(:sales_modeling_color,name:'赤') }
  let(:blue) { create(:sales_modeling_color,name:'青') }
  let(:black) { create(:sales_modeling_color,name:'黒') }

  let(:normal) { create(:sales_modeling_product_category,name:'定価') }
  let(:special) { create(:sales_modeling_product_category,name:'特価') }
  let(:null) { create(:sales_modeling_product_category,name:'無し') }

  let(:jan) { SalesModeling::JANCode.new('1234567890123')}

  let(:product_a) { { code:jan.code,name:'商品A',size:s,color:blue, product_category:special } }
  let(:product_b) { { code:jan.code,name:'商品B',size:m,color:black, product_category:normal } }
  let(:product_c) { { code:jan.code,name:'商品C',size:l,color:red, product_category:null } }

  describe '#save!' do
    example '商品A サイズ:S・カラー:青・商品区分:特価の商品' do
      product = SalesModeling::Product.new
      product.name = '商品A'
      product.jan = jan
      product.size = s
      product.color = blue
      product.product_category = special
      product.save!

      new_product = SalesModeling::Product.first
      check(new_product,product_a)
    end

    example '商品B サイズ:M・カラー:黒・商品区分:定価の商品' do
      product = SalesModeling::Product.new({
        name: '商品B',
        jan: jan,
        size: m,
        color: black,
        product_category: normal
      })
      product.save!

      new_product = SalesModeling::Product.first
      check(new_product,product_b)
    end

    example '商品C サイズ:L・カラー:赤・商品区分:無し' do
      product = { code:jan.code,name:'商品C',size:l,color:red, product_category:null }
      product = SalesModeling::Product.new(product)
      product.save!

      new_product = SalesModeling::Product.first
      check(new_product,product_c)
    end
  end

  describe '#count' do
    example '商品A x 1, 商品B x 2, 商品C x 3' do
      1.times do
        SalesModeling::Product.new(product_a).save!
      end
      2.times do
        SalesModeling::Product.new(product_b).save!
      end
      3.times do
        SalesModeling::Product.new(product_c).save!
      end

      expect(SalesModeling::Product.count).to eq 6
      expect(SalesModeling::Product.where(name:'商品A').count).to eq 1
      expect(SalesModeling::Product.where(name:'商品B').count).to eq 2
      expect(SalesModeling::Product.where(name:'商品C').count).to eq 3
    end
  end
end

private

def check(new_product,check_product)
  expect(new_product.code).to eq check_product[:code]
  expect(new_product.name).to eq check_product[:name]
  expect(new_product.size.name).to eq check_product[:size].name
  expect(new_product.color.name).to eq check_product[:color].name
  expect(new_product.product_category.name).to eq check_product[:product_category].name
end

