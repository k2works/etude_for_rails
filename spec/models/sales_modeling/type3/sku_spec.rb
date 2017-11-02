require 'rails_helper'

RSpec.describe SalesModeling::Type3::Sku, type: :model do
  let(:product_p0001) { create(:product_1) }
  let(:product_p0002) { create(:product_1, code:SalesModeling::Type3::ValueObject::ProductCode.new('p0002')) }
  let(:product_p0003) { create(:product_1, code:SalesModeling::Type3::ValueObject::ProductCode.new('p0003')) }
  let(:l_size) { create(:size_category,name:'L') }
  let(:m_size) { create(:size_category,name:'M') }
  let(:s_size) { create(:size_category,name:'S') }
  let(:navy_color) { create(:color_category,name:'ネイビー')}
  let(:pink_color) { create(:color_category,name:'ピンク')}
  let(:white_color) { create(:color_category,name:'ホワイト')}
  let(:hundredYen) { SalesModeling::Type3::ValueObject::Money.new(100)}
  let(:tenDollar) { SalesModeling::Type3::ValueObject::Money.new(10,'$')}
  let(:notSet) { SalesModeling::Type3::ValueObject::Money.new(nil,nil)}


  describe '#create' do
    example '品番:p0001 サイズ；L・カラー；ネイビー 仕入単価:100円 販売単価:200円' do
      product_p0001.skus.build
      product_p0001.skus.first.size_category = l_size
      product_p0001.skus.first.color_category = navy_color
      product_p0001.skus.first.unit_purchase_price = hundredYen
      product_p0001.skus.first.unit_sales_price = hundredYen.+(SalesModeling::Type3::ValueObject::Money.new(100))
      product_p0001.save!

      sku = SalesModeling::Type3::Sku.first
      expect(sku.size_category.name).to eq 'L'
      expect(sku.color_category.name).to eq 'ネイビー'
      expect(sku.unit_purchase_price_amount).to eq 100
      expect(sku.unit_sales_price_amount).to eq 200
    end

    example '品番:p0001 サイズ；L,M,S' do
      {'0':l_size, '1':m_size, '2':s_size}.each do |n,size|
        n = n.to_s.to_i
        product_p0001.skus.build
        product_p0001.skus[n].size_category = size
        product_p0001.skus[n].color_category = navy_color
        product_p0001.skus[n].unit_purchase_price = hundredYen
        product_p0001.skus[n].unit_sales_price = hundredYen.+(SalesModeling::Type3::ValueObject::Money.new(100))
      end
      product_p0001.save!

      first_sku = SalesModeling::Type3::Sku.first
      expect(first_sku.size_category.name).to eq 'L'
      second_sku = SalesModeling::Type3::Sku.second
      expect(second_sku.size_category.name).to eq 'M'
      third_sku = SalesModeling::Type3::Sku.third
      expect(third_sku.size_category.name).to eq 'S'
    end

    example '品番:p0001 サイズ:L カラー:ネイビー 品番:p0002 サイズ:M カラー：ピンク 品番:p0003 サイズ:S カラー:ホワイト' do
      build_sku = lambda do |product,size,color|
        product.skus.build
        product.skus.first.size_category = size
        product.skus.first.color_category = color
        product.skus.first.unit_purchase_price = hundredYen
        product.skus.first.unit_sales_price = hundredYen.+(SalesModeling::Type3::ValueObject::Money.new(100))
        product.save!
      end

      build_sku.call(product_p0001, l_size, navy_color)
      build_sku.call(product_p0002, m_size, pink_color)
      build_sku.call(product_p0003, s_size, white_color)

      p0001_skus = SalesModeling::Type3::Product.first.skus
      expect(p0001_skus.first.size_category.name).to eq 'L'
      expect(p0001_skus.first.color_category.name).to eq 'ネイビー'

      p0002_skus = SalesModeling::Type3::Product.second.skus
      expect(p0002_skus.first.size_category.name).to eq 'M'
      expect(p0002_skus.first.color_category.name).to eq 'ピンク'

      p0003_skus = SalesModeling::Type3::Product.third.skus
      expect(p0003_skus.first.size_category.name).to eq 'S'
      expect(p0003_skus.first.color_category.name).to eq 'ホワイト'
    end

    example 'フルラインナップ' do
      build_sku = lambda do |product,color|
        {'0':l_size, '1':m_size, '2':s_size}.each do |n,size|
          n = n.to_s.to_i
          product.skus.build
          product.skus[n].size_category = size
          product.skus[n].color_category = navy_color
          product.skus[n].unit_purchase_price = hundredYen
          product.skus[n].unit_sales_price = hundredYen.+(SalesModeling::Type3::ValueObject::Money.new(100))
        end
        product.save!
      end

      build_sku.call(product_p0001, navy_color)
      build_sku.call(product_p0002, pink_color)
      build_sku.call(product_p0003, white_color)

      expect(SalesModeling::Type3::Sku.count).to eq(9)
    end
  end
end
