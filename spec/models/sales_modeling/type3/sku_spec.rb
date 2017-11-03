require 'rails_helper'
include SalesModeling::Type3

RSpec.describe SalesModeling::Type3::Sku, type: :model do
  let(:product_p0001) { create(:product_1) }
  let(:product_p0002) { create(:product_1, code:ValueObject::ProductCode.new('p0002').code) }
  let(:product_p0003) { create(:product_1, code:ValueObject::ProductCode.new('p0003').code) }
  let(:l_size) { create(:size_category,name:'L') }
  let(:m_size) { create(:size_category,name:'M') }
  let(:s_size) { create(:size_category,name:'S') }
  let(:navy_color) { create(:color_category,name:'ネイビー')}
  let(:pink_color) { create(:color_category,name:'ピンク')}
  let(:white_color) { create(:color_category,name:'ホワイト')}
  let(:hundredYen) { ValueObject::Money.new(100)}
  let(:twohundredYen) { hundredYen.+(ValueObject::Money.new(100)) }
  let(:tenDollar) { ValueObject::Money.new(10,'$')}
  let(:notSet) { ValueObject::Money.new(nil,nil)}

  let(:select_l_size_products) { Product.includes(:skus).references(:sales_modeling_type3_skus).where("sales_modeling_type3_skus.size_category_id = ?",l_size.id) }
  let(:select_m_size_products) { Product.includes(:skus).references(:sales_modeling_type3_skus).where("sales_modeling_type3_skus.size_category_id = ?",m_size.id) }
  let(:select_navy_color_products) { Product.includes(:skus).references(:sales_modeling_type3_skus).where("sales_modeling_type3_skus.color_category_id = ?",navy_color.id) }
  let(:select_white_color_products) { Product.includes(:skus).references(:sales_modeling_type3_skus).where("sales_modeling_type3_skus.color_category_id = ?",white_color.id) }
  let(:select_pink_color_products) { Product.includes(:skus).references(:sales_modeling_type3_skus).where("sales_modeling_type3_skus.color_category_id = ?",pink_color.id) }
  let(:select_l_size_and_white_color_products) { Product.includes(:skus).references(:sales_modeling_type3_skus).where("sales_modeling_type3_skus.size_category_id = ? and sales_modeling_type3_skus.color_category_id = ?",l_size.id, white_color.id) }
  let(:select_s_size_and_white_color_products) { Product.includes(:skus).references(:sales_modeling_type3_skus).where("sales_modeling_type3_skus.size_category_id = ? and sales_modeling_type3_skus.color_category_id = ?",s_size.id, white_color.id) }

  let(:select_product_p0001) { Product.includes(:skus).references(:sales_modeling_type3_skus).where(code: 'p0001') }
  let(:select_products) { Product.all }
  let(:select_skus) { Sku.all }
  let(:select_l_size_skus) { Sku.where(size_category_id: l_size.id) }
  let(:select_white_color_skus) { Sku.where(color_category_id: white_color.id) }
  let(:select_l_size_and_white_color_skus) { Sku.where(size_category_id: l_size.id, color_category_id: white_color.id) }

  let(:find_first_product) { Product.first }
  let(:find_second_product) { Product.second }
  let(:find_third_product) { Product.third }
  let(:find_first_sku) { Sku.first }
  let(:find_second_sku) { Sku.second }
  let(:find_third_sku) { Sku.third }

  sku_code_value = ->(product_code,code) { ValueObject::SkuCode.new(product_code,code) }

  def create_p0001_sku(sku_code_value)
    product_p0001.skus.build
    product_p0001.skus.first.sku_code = sku_code_value.call(product_p0001.product_code.code, '1')
    product_p0001.skus.first.size = l_size
    product_p0001.skus.first.color = navy_color
    product_p0001.skus.first.unit_purchase_price = hundredYen
    product_p0001.skus.first.unit_sales_price = twohundredYen
    product_p0001.save!
  end

  def create_full_size_sku(sku_code_value)
    {'0': l_size, '1': m_size, '2': s_size}.each do |n, size|
      n = n.to_s.to_i
      product_p0001.skus.build
      product_p0001.skus[n].sku_code = sku_code_value.call(product_p0001.product_code.code, n.to_s)
      product_p0001.skus[n].size = size
      product_p0001.skus[n].color = navy_color
      product_p0001.skus[n].unit_purchase_price = hundredYen
      product_p0001.skus[n].unit_sales_price = twohundredYen
    end
    product_p0001.save!
  end

  def create_3_pattern_sku(sku_code_value)
    build_sku = lambda do |product, size, color|
      product.skus.build
      product.skus.first.sku_code = sku_code_value.call(product.product_code.code, '1')
      product.skus.first.size = size
      product.skus.first.color = color
      product.skus.first.unit_purchase_price = hundredYen
      product.skus.first.unit_sales_price = twohundredYen
      product.save!
    end

    build_sku.call(product_p0001, l_size, navy_color)
    build_sku.call(product_p0002, m_size, pink_color)
    build_sku.call(product_p0003, s_size, white_color)
  end

  def create_full_lineup(sku_code_value)
    build_sku = lambda do |product, color|
      {'0': l_size, '1': m_size, '2': s_size}.each do |n, size|
        n = n.to_s.to_i
        product.skus.build
        product.skus[n].sku_code = sku_code_value.call(product.product_code.code, n.to_s)
        product.skus[n].size = size
        product.skus[n].color = color
        product.skus[n].unit_purchase_price = hundredYen
        product.skus[n].unit_sales_price = twohundredYen
      end
      product.save!
    end

    build_sku.call(product_p0001, navy_color)
    build_sku.call(product_p0002, pink_color)
    build_sku.call(product_p0003, white_color)
  end

  describe '#create' do
    example '品番:p0001 サイズ；L・カラー；ネイビー 仕入単価:100円 販売単価:200円' do
      create_p0001_sku(sku_code_value)

      expect(find_first_sku.sku_code.code).to eq 'p0001-00001'
      expect(find_first_sku.size.name).to eq 'L'
      expect(find_first_sku.color.name).to eq 'ネイビー'
      expect(find_first_sku.unit_purchase_price_amount).to eq 100
      expect(find_first_sku.unit_sales_price_amount).to eq 200
    end

    example '品番:p0001 サイズ；L,M,S' do
      create_full_size_sku(sku_code_value)

      expect(find_first_sku.size.name).to eq 'L'
      expect(find_second_sku.size.name).to eq 'M'
      expect(find_third_sku.size.name).to eq 'S'
    end

    example '品番:p0001 サイズ:L カラー:ネイビー 品番:p0002 サイズ:M カラー：ピンク 品番:p0003 サイズ:S カラー:ホワイト' do
      create_3_pattern_sku(sku_code_value)

      p0001_skus = find_first_product.skus
      expect(p0001_skus.first.size.name).to eq 'L'
      expect(p0001_skus.first.color.name).to eq 'ネイビー'

      p0002_skus = find_second_product.skus
      expect(p0002_skus.first.size.name).to eq 'M'
      expect(p0002_skus.first.color.name).to eq 'ピンク'

      p0003_skus = find_third_product.skus
      expect(p0003_skus.first.size.name).to eq 'S'
      expect(p0003_skus.first.color.name).to eq 'ホワイト'
    end

    example 'フルラインナップ' do
      create_full_lineup(sku_code_value)

      expect(select_skus.count).to eq(9)
    end
  end

  describe '#select' do
    context 'フルラインナップ' do
      before(:each) do
        create_full_lineup(sku_code_value)
      end

      example '品番:p0001 p0002 p0003 サイズ:L' do
        expect(select_l_size_products.count).to eq 3

        select_l_size_products.each do |product|
          product.skus.each do |sku|
            expect(sku.size.name).to eq 'L'
          end
        end
      end

      example '品番:p0002 カラー:ピンク' do
        expect(select_pink_color_products.count).to eq 1

        select_pink_color_products.each do |product|
          expect(product.skus.count).to eq 3
          expect(product.product_code.code).to eq 'p0002'
          product.skus.each do |sku|
            expect(sku.color.name).to eq 'ピンク'
          end
        end
      end

      example '品番p0003 サイズ:S カラー：ホワイト' do
        expect(select_s_size_and_white_color_products.count).to eq 1

        select_s_size_and_white_color_products.each do |product|
          expect(product.product_code.code).to eq 'p0003'
          product.skus.each do |sku|
            expect(sku.size.name).to eq 'S'
            expect(sku.color.name).to eq 'ホワイト'
          end
        end
      end
    end
  end

  describe '#update' do
    context 'フルラインナップ' do
      before(:each) do
        create_full_lineup(sku_code_value)
      end

      example '品番:p0001 p0002 p0003 サイズ:L -> M' do
        select_l_size_products.each do |product|
          product.skus.each do |sku|
            sku.size = m_size
            sku.save!
          end
        end

        expect(select_l_size_products.count).to eq 0

        select_m_size_products.each do |product|
          product.skus.each do |sku|
            expect(sku.size.name).to eq 'M'
          end
        end
      end

      example '品番:p0001 カラー:ネイビー -> ホワイト' do
        select_navy_color_products.each do |product|
          product.skus.each do |sku|
            sku.color = white_color
            sku.save!
          end
        end

        expect(select_navy_color_products.count).to eq 0

        select_white_color_products.each do |product|
          product.skus.each do |sku|
            expect(sku.color.name).to eq 'ホワイト'
          end
        end
      end
    end
  end

  describe '#delete' do
    context 'フルラインナップ' do
      before(:each) do
        create_full_lineup(sku_code_value)
      end

      example '全件削除' do
        select_products.destroy_all

        expect(select_products.count).to eq 0
        expect(select_skus.count).to eq 0
      end

      example '全件削除' do
        select_products.delete_all

        expect(select_products.count).to eq 0
        expect(select_skus.count).not_to eq 0
      end

      example '品番:p0001' do
        select_product_p0001.destroy_all

        expect(select_product_p0001.count).to eq 0
        expect(select_skus.count).to eq 6
      end

      example 'サイズ:L' do
        select_l_size_products.destroy_all

        expect(select_l_size_products.count).to eq 0
        expect(select_l_size_skus.count).to eq 0
      end

      example 'カラー:ホワイト' do
        select_white_color_products.destroy_all

        expect(select_white_color_products.count).to eq 0
        expect(select_white_color_skus.count).to eq 0
      end

      example 'サイズ:L カラー：ホワイト' do
        select_l_size_and_white_color_products.destroy_all

        expect(select_l_size_and_white_color_products.count).to eq 0
        expect(select_l_size_and_white_color_skus.count).to eq 0
      end
    end
  end
end
