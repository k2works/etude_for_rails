require 'rails_helper'

RSpec.describe SalesModeling::Type2::Product, type: :model do
  let(:size) { create(:sales_modeling_type2_category_class,code:'1',name:'サイズ') }
  let(:size_parent) { create(:sales_modeling_type2_category) }
  let(:s) { create(:sales_modeling_type2_category,code:'1',name:'S', parent_category:size_parent, sales_modeling_type2_category_class:size) }
  let(:m) { create(:sales_modeling_type2_category,code:'2',name:'M', parent_category:size_parent, sales_modeling_type2_category_class:size) }
  let(:l) { create(:sales_modeling_type2_category,code:'3',name:'L', parent_category:size_parent, sales_modeling_type2_category_class:size) }

  let(:color) { create(:sales_modeling_type2_category_class,code:'2',name:'色') }
  let(:color_parent) { create(:sales_modeling_type2_category) }
  let(:red) { create(:sales_modeling_type2_category,code:'1',name:'赤', parent_category:color_parent, sales_modeling_type2_category_class:color) }
  let(:blue) { create(:sales_modeling_type2_category,code:'2',name:'青', parent_category:color_parent, sales_modeling_type2_category_class:color) }
  let(:black) { create(:sales_modeling_type2_category,code:'3',name:'黒', parent_category:color_parent, sales_modeling_type2_category_class:color) }

  let(:product_category) { create(:sales_modeling_type2_category_class,code:'3',name:'商品区分') }
  let(:product_category_parent) { create(:sales_modeling_type2_category) }
  let(:normal) { create(:sales_modeling_type2_category,code:'1',name:'定価', parent_category:product_category_parent, sales_modeling_type2_category_class:product_category) }
  let(:special) { create(:sales_modeling_type2_category,code:'2',name:'特価', parent_category:product_category_parent, sales_modeling_type2_category_class:product_category) }
  let(:null) { create(:sales_modeling_type2_category,code:'3',name:'無し', parent_category:product_category_parent, sales_modeling_type2_category_class:product_category) }

  let(:product_code) { SalesModeling::Type2::ProductCode.new('1234567890')}

  let(:hundredYen) { SalesModeling::Type2::Money.new(100)}
  let(:tenDollar) { SalesModeling::Type2::Money.new(10,'$')}
  let(:notSet) { SalesModeling::Type2::Money.new(nil,nil)}

  let(:product_a) { {
      code:product_code.code,
      name:'商品A',
      size:s,
      color:blue,
      product_category:special,
      unit_purchase_price_amount:hundredYen.amount,
      unit_purchase_price_currency:hundredYen.currency,
      unit_sales_price_amount:hundredYen.+(SalesModeling::Type2::Money.new(100)).amount,
      unit_sales_price_currency:hundredYen.+(SalesModeling::Type2::Money.new(100)).currency
  }}
  let(:product_b) { {
      code:product_code.code,
      name:'商品B',
      size:m,
      color:black,
      product_category:normal,
      unit_purchase_price_amount:tenDollar.amount,
      unit_purchase_price_currency:tenDollar.currency,
      unit_sales_price_amount:tenDollar.+(SalesModeling::Type2::Money.new(10,'$')).amount,
      unit_sales_price_currency:tenDollar.+(SalesModeling::Type2::Money.new(10,'$')).currency
  } }
  let(:product_c) { {
      code:product_code.code,
      name:'商品C',
      size:l,
      color:red,
      product_category:null,
  } }

  describe '#save!' do
    example '商品A サイズ:S・カラー:青・商品区分:特価の商品 仕入単価:100円 販売単価:200円' do
      product = SalesModeling::Type2::Product.new
      product.name = '商品A'
      product.product_code = product_code
      product.size = s
      product.color = blue
      product.product_category = special
      product.unit_purchase_price = hundredYen
      product.unit_sales_price = hundredYen.+(SalesModeling::Type2::Money.new(100))
      product.save!

      new_product = SalesModeling::Type2::Product.first
      check(new_product,product_a)
    end

    example '商品B サイズ:M・カラー:黒・商品区分:定価の商品 仕入単価:10ドル 販売単価:20ドル' do
      product = SalesModeling::Type2::Product.new({
                                                      name: '商品B',
                                                      product_code: product_code,
                                                      size: m,
                                                      color: black,
                                                      product_category: normal,
                                                      unit_purchase_price: tenDollar,
                                                      unit_sales_price: tenDollar.+(SalesModeling::Type1::Money.new(10,'$'))
                                                  })
      product.save!

      new_product = SalesModeling::Type2::Product.first
      check(new_product,product_b)
    end

    example '商品C サイズ:L・カラー:赤・商品区分:無し 単価未設定' do
      product = {
          product_code:product_code,
          name:'商品C',
          size:l,
          color:red,
          product_category:null,
          unit_purchase_price: notSet,
          unit_sales_price: notSet
      }
      product = SalesModeling::Type2::Product.new(product)
      product.save!

      new_product = SalesModeling::Type2::Product.first
      check(new_product,product_c)
    end
  end

  describe '#count' do
    example '商品A x 1, 商品B x 2, 商品C x 3' do
      1.times do
        SalesModeling::Type2::Product.new(product_a).save!
      end
      2.times do
        SalesModeling::Type2::Product.new(product_b).save!
      end
      3.times do
        SalesModeling::Type2::Product.new(product_c).save!
      end

      expect(SalesModeling::Type2::Product.count).to eq 6
      expect(SalesModeling::Type2::Product.where(name:'商品A').count).to eq 1
      expect(SalesModeling::Type2::Product.where(name:'商品B').count).to eq 2
      expect(SalesModeling::Type2::Product.where(name:'商品C').count).to eq 3
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
  expect(new_product.unit_purchase_price_amount).to eq check_product[:unit_purchase_price_amount]
  expect(new_product.unit_purchase_price_currency).to eq check_product[:unit_purchase_price_currency]
  expect(new_product.unit_sales_price_amount).to eq check_product[:unit_sales_price_amount]
  expect(new_product.unit_sales_price_currency).to eq check_product[:unit_sales_price_currency]
end
