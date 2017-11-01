require 'rails_helper'

RSpec.describe SalesModeling::Type1::Product, type: :model do
  let(:s) { create(:sales_modeling_type1_size,name:'S') }
  let(:m) { create(:sales_modeling_type1_size,name:'M') }
  let(:l) { create(:sales_modeling_type1_size,name:'L') }

  let(:red) { create(:sales_modeling_type1_color,name:'赤') }
  let(:blue) { create(:sales_modeling_type1_color,name:'青') }
  let(:black) { create(:sales_modeling_type1_color,name:'黒') }

  let(:normal) { create(:sales_modeling_type1_product_category,name:'定価') }
  let(:special) { create(:sales_modeling_type1_product_category,name:'特価') }
  let(:null) { create(:sales_modeling_type1_product_category,name:'無し') }

  let(:jan) { SalesModeling::Type1::JANCode.new('1234567890123')}

  let(:hundredYen) { SalesModeling::Type1::Money.new(100)}
  let(:tenDollar) { SalesModeling::Type1::Money.new(10,'$')}
  let(:notSet) { SalesModeling::Type1::Money.new(nil,nil)}

  let(:product_a) { {
      code:jan.code,name:'商品A',
      size:s,
      color:blue,
      product_category:special,
      unit_purchase_price_amount:hundredYen.amount,
      unit_purchase_price_currency:hundredYen.currency,
      unit_sales_price_amount:hundredYen.+(SalesModeling::Type1::Money.new(100)).amount,
      unit_sales_price_currency:hundredYen.+(SalesModeling::Type1::Money.new(100)).currency
  }}
  let(:product_b) { {
      code:jan.code,
      name:'商品B',
      size:m,
      color:black,
      product_category:normal,
      unit_purchase_price_amount:tenDollar.amount,
      unit_purchase_price_currency:tenDollar.currency,
      unit_sales_price_amount:tenDollar.+(SalesModeling::Type1::Money.new(10,'$')).amount,
      unit_sales_price_currency:tenDollar.+(SalesModeling::Type1::Money.new(10,'$')).currency
  } }
  let(:product_c) { {
      code:jan.code,
      name:'商品C',
      size:l,
      color:red,
      product_category:null,
  } }

  describe '#save!' do
    example '商品A サイズ:S・カラー:青・商品区分:特価の商品 仕入単価:100円 販売単価:200円' do
      product = SalesModeling::Type1::Product.new
      product.name = '商品A'
      product.jan = jan
      product.size = s
      product.color = blue
      product.product_category = special
      product.unit_purchase_price = hundredYen
      product.unit_sales_price = hundredYen.+(SalesModeling::Type1::Money.new(100))
      product.save!

      new_product = SalesModeling::Type1::Product.first
      check(new_product,product_a)
    end

    example '商品B サイズ:M・カラー:黒・商品区分:定価の商品 仕入単価:10ドル 販売単価:20ドル' do
      product = SalesModeling::Type1::Product.new({
                                               name: '商品B',
                                               jan: jan,
                                               size: m,
                                               color: black,
                                               product_category: normal,
                                               unit_purchase_price: tenDollar,
                                               unit_sales_price: tenDollar.+(SalesModeling::Type1::Money.new(10,'$'))
                                           })
      product.save!

      new_product = SalesModeling::Type1::Product.first
      check(new_product,product_b)
    end

    example '商品C サイズ:L・カラー:赤・商品区分:無し 単価未設定' do
      product = {
          code:jan.code,
          name:'商品C',
          size:l,
          color:red,
          product_category:null,
          unit_purchase_price: notSet,
          unit_sales_price: notSet
      }
      product = SalesModeling::Type1::Product.new(product)
      product.save!

      new_product = SalesModeling::Type1::Product.first
      check(new_product,product_c)
    end
  end

  describe '#count' do
    example '商品A x 1, 商品B x 2, 商品C x 3' do
      1.times do
        SalesModeling::Type1::Product.new(product_a).save!
      end
      2.times do
        SalesModeling::Type1::Product.new(product_b).save!
      end
      3.times do
        SalesModeling::Type1::Product.new(product_c).save!
      end

      expect(SalesModeling::Type1::Product.count).to eq 6
      expect(SalesModeling::Type1::Product.where(name:'商品A').count).to eq 1
      expect(SalesModeling::Type1::Product.where(name:'商品B').count).to eq 2
      expect(SalesModeling::Type1::Product.where(name:'商品C').count).to eq 3
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
end