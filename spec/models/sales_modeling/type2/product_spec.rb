require 'rails_helper'

RSpec.describe SalesModeling::Type2::Product, type: :model do
  let(:size) { create(:sales_modeling_type2_category_class,code:'1',name:'サイズ') }
  let(:size_parent) { create(:sales_modeling_type2_category) }
  let(:s) { create(:sales_modeling_type2_category,code:'00001',name:'S', parent_category:size_parent, sales_modeling_type2_category_class:size) }
  let(:m) { create(:sales_modeling_type2_category,code:'00002',name:'M', parent_category:size_parent, sales_modeling_type2_category_class:size) }
  let(:l) { create(:sales_modeling_type2_category,code:'00003',name:'L', parent_category:size_parent, sales_modeling_type2_category_class:size) }

  let(:color) { create(:sales_modeling_type2_category_class,code:'2',name:'色') }
  let(:color_parent) { create(:sales_modeling_type2_category) }
  let(:red) { create(:sales_modeling_type2_category,code:'00001',name:'赤', parent_category:color_parent, sales_modeling_type2_category_class:color) }
  let(:blue) { create(:sales_modeling_type2_category,code:'00002',name:'青', parent_category:color_parent, sales_modeling_type2_category_class:color) }
  let(:black) { create(:sales_modeling_type2_category,code:'00003',name:'黒', parent_category:color_parent, sales_modeling_type2_category_class:color) }

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
      size_category:s,
      color_category:blue,
      product_type_category:special,
      unit_purchase_price_amount:hundredYen.amount,
      unit_purchase_price_currency:hundredYen.currency,
      unit_sales_price_amount:hundredYen.+(SalesModeling::Type2::Money.new(100)).amount,
      unit_sales_price_currency:hundredYen.+(SalesModeling::Type2::Money.new(100)).currency
  }}
  let(:product_b) { {
      code:product_code.code,
      name:'商品B',
      size_category:m,
      color_category:black,
      product_type_category:normal,
      unit_purchase_price_amount:tenDollar.amount,
      unit_purchase_price_currency:tenDollar.currency,
      unit_sales_price_amount:tenDollar.+(SalesModeling::Type2::Money.new(10,'$')).amount,
      unit_sales_price_currency:tenDollar.+(SalesModeling::Type2::Money.new(10,'$')).currency
  } }
  let(:product_c) { {
      code:product_code.code,
      name:'商品C',
      size_category:l,
      color_category:red,
      product_type_category:null,
  } }

  describe '#save!' do
    example '商品A サイズ:S・カラー:青・商品区分:特価の商品 仕入単価:100円 販売単価:200円' do
      product = SalesModeling::Type2::Product.new
      product.name = '商品A'
      product.product_code = product_code
      product.size_category = s
      product.color_category = blue
      product.product_type_category = special
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
                                                      size_category: m,
                                                      color_category: black,
                                                      product_type_category: normal,
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
          size_category:l,
          color_category:red,
          product_type_category:null,
          unit_purchase_price: notSet,
          unit_sales_price: notSet
      }
      product = SalesModeling::Type2::Product.new(product)
      product.save!

      new_product = SalesModeling::Type2::Product.first
      check(new_product,product_c)
    end
  end

  describe '#update' do
    example '商品A サイズ:S -> XS' do
      create(:sales_modeling_type2_product,product_a)
      update_product = SalesModeling::Type2::Product.first
      update_product.size = SalesModeling::Type2::Size.new('2','XS')
      update_product.save!

      expect(SalesModeling::Type2::CategoryClass.where(name:'サイズ').first.sales_modeling_type2_categories.count).to eq 2
      expect(update_product.size_category.code).to eq '00002'
      expect(update_product.size_category.name).to eq 'XS'
    end

    example '商品A 色:青 -> 緑' do
      create(:sales_modeling_type2_product,product_a)
      update_product = SalesModeling::Type2::Product.first
      update_product.color = SalesModeling::Type2::Color.new('2','緑')
      update_product.save!

      expect(SalesModeling::Type2::CategoryClass.where(name:'色').first.sales_modeling_type2_categories.count).to eq 2
      expect(update_product.color_category.code).to eq '00002'
      expect(update_product.color_category.name).to eq '緑'
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

  private

  def check(new_product,check_product)
    expect(new_product.code).to eq check_product[:code]
    expect(new_product.name).to eq check_product[:name]
    expect(new_product.size_category.name).to eq check_product[:size_category].name
    expect(new_product.color_category.name).to eq check_product[:color_category].name
    expect(new_product.product_type_category.name).to eq check_product[:product_type_category].name
    expect(new_product.unit_purchase_price_amount).to eq check_product[:unit_purchase_price_amount]
    expect(new_product.unit_purchase_price_currency).to eq check_product[:unit_purchase_price_currency]
    expect(new_product.unit_sales_price_amount).to eq check_product[:unit_sales_price_amount]
    expect(new_product.unit_sales_price_currency).to eq check_product[:unit_sales_price_currency]
  end
end