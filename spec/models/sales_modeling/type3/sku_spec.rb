# frozen_string_literal: true

require 'rails_helper'
include SalesModeling::Type3

RSpec.describe SalesModeling::Type3::Sku, type: :model do
  let(:product_p0001) { create(:product_1) }
  let(:product_p0002) { create(:product_1, code: ValueObject::ProductCode.new('p0002').code) }
  let(:product_p0003) { create(:product_1, code: ValueObject::ProductCode.new('p0003').code) }
  let(:l_size) { create(:size_category, name: 'L') }
  let(:m_size) { create(:size_category, name: 'M') }
  let(:s_size) { create(:size_category, name: 'S') }
  let(:navy_color) { create(:color_category, name: 'ネイビー') }
  let(:pink_color) { create(:color_category, name: 'ピンク') }
  let(:white_color) { create(:color_category, name: 'ホワイト') }
  let(:hundredYen) { ValueObject::UnitPurchasePrice.new(100) }
  let(:twohundredYen) { hundredYen.+(ValueObject::UnitSalesPrice.new(100)) }
  let(:tenDollar) { ValueObject::UnitPurchasePrice.new(10, '$') }
  let(:notSet) { ValueObject::UnitPurchasePrice.new(nil, nil) }

  let(:products_repo) { ::SalesModeling::ProductsRepo.new }
  let(:l_size_products) { products_repo.select_by_size(l_size) }
  let(:m_size_products) { products_repo.select_by_size(m_size) }
  let(:navy_color_products) { products_repo.select_by_color(navy_color) }
  let(:white_color_products) { products_repo.select_by_color(white_color) }
  let(:pink_color_products) { products_repo.select_by_color(pink_color) }
  let(:l_size_and_white_color_products) { products_repo.select_by_size_and_color(l_size, white_color) }
  let(:s_size_and_white_color_products) { products_repo.select_by_size_and_color(s_size, white_color) }
  let(:products_p0001) { products_repo.select_by_code('p0001') }
  let(:products) { products_repo.all }
  let(:skus) { products_repo.all_sku }
  let(:l_size_skus) { products_repo.select_all_sku_by_size(l_size) }
  let(:m_size_skus) { products_repo.select_all_sku_by_size(m_size) }
  let(:white_color_skus) { products_repo.select_all_sku_by_color(white_color) }
  let(:l_size_and_white_color_skus) { products_repo.select_all_sku_by_size_and_color(l_size, white_color) }
  let(:first_product) { products_repo.select_first }
  let(:second_product) { products_repo.select_second }
  let(:third_product) { products_repo.select_third }
  let(:first_sku) { products_repo.select_all_sku_first }
  let(:second_sku) { products_repo.select_all_sku_second }
  let(:third_sku) { products_repo.select_all_sku_third }

  def create_p0001_sku
    sku = products_repo.new_sku(
      size: l_size,
      color: navy_color,
      unit_purchase_price: hundredYen,
      unit_sales_price: twohundredYen
    )
    products_repo.save(product_p0001, [sku])
  end

  def create_full_size_sku
    skus = []
    [l_size, m_size, s_size].each do |size|
      sku = products_repo.new_sku(
        size: size,
        color: navy_color,
        unit_purchase_price: hundredYen,
        unit_sales_price: twohundredYen
      )
      skus << sku
    end
    products_repo.save(product_p0001, skus)
  end

  def create_3_pattern_sku
    build_sku = lambda do |product, size, color|
      sku = products_repo.new_sku(
        size: size,
        color: color,
        unit_purchase_price: hundredYen,
        unit_sales_price: twohundredYen
      )
      products_repo.save(product, [sku])
    end

    build_sku.call(product_p0001, l_size, navy_color)
    build_sku.call(product_p0002, m_size, pink_color)
    build_sku.call(product_p0003, s_size, white_color)
  end

  def create_full_lineup
    build_sku = lambda do |product, color|
      skus = []
      [l_size, m_size, s_size].each do |size|
        sku = products_repo.new_sku(
          size: size,
          color: color,
          unit_purchase_price: hundredYen,
          unit_sales_price: twohundredYen
        )
        skus << sku
      end
      products_repo.save(product, skus)
    end

    build_sku.call(product_p0001, navy_color)
    build_sku.call(product_p0002, pink_color)
    build_sku.call(product_p0003, white_color)
  end

  describe '#create' do
    example '品番:p0001 サイズ；L・カラー；ネイビー 仕入単価:100円 販売単価:200円' do
      create_p0001_sku

      expect(first_sku.sku_code.code).to eq 'p0001-00001'
      expect(first_sku.size.name).to eq 'L'
      expect(first_sku.color.name).to eq 'ネイビー'
      expect(first_sku.unit_purchase_price).to eq hundredYen
      expect(first_sku.unit_purchase_price_amount).to eq 100
      expect(first_sku.unit_sales_price).to eq twohundredYen
      expect(first_sku.unit_sales_price_amount).to eq 200
    end

    example '品番:p0001 サイズ；L,M,S' do
      create_full_size_sku

      expect(first_sku.size.name).to eq 'L'
      expect(second_sku.size.name).to eq 'M'
      expect(third_sku.size.name).to eq 'S'
    end

    example '品番:p0001 サイズ:L カラー:ネイビー 品番:p0002 サイズ:M カラー：ピンク 品番:p0003 サイズ:S カラー:ホワイト' do
      create_3_pattern_sku

      p0001_skus = first_product.skus
      expect(p0001_skus.first.size.name).to eq 'L'
      expect(p0001_skus.first.color.name).to eq 'ネイビー'

      p0002_skus = second_product.skus
      expect(p0002_skus.first.size.name).to eq 'M'
      expect(p0002_skus.first.color.name).to eq 'ピンク'

      p0003_skus = third_product.skus
      expect(p0003_skus.first.size.name).to eq 'S'
      expect(p0003_skus.first.color.name).to eq 'ホワイト'
    end

    example 'フルラインナップ' do
      create_full_lineup

      expect(skus.count).to eq(9)
    end
  end

  describe '#select' do
    context 'フルラインナップ' do
      before(:each) do
        create_full_lineup
      end

      example '品番:p0001 p0002 p0003 サイズ:L' do
        expect(l_size_products.count).to eq 3

        l_size_products.each do |product|
          product.skus.each do |sku|
            expect(sku.size.name).to eq 'L'
          end
        end
      end

      example '品番:p0002 カラー:ピンク' do
        expect(pink_color_products.count).to eq 1

        pink_color_products.each do |product|
          expect(product.skus.count).to eq 3
          expect(product.product_code.code).to eq 'p0002'
          product.skus.each do |sku|
            expect(sku.color.name).to eq 'ピンク'
          end
        end
      end

      example '品番p0003 サイズ:S カラー：ホワイト' do
        expect(s_size_and_white_color_products.count).to eq 1

        s_size_and_white_color_products.each do |product|
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
        create_full_lineup
      end

      example '品番:p0001 p0002 p0003 サイズ:L -> M' do
        l_size_products.each do |product|
          products_repo.update_sku(product, size: m_size)
        end

        expect(m_size_skus.count).to eq 6
        expect(l_size_products.count).to eq 0

        m_size_products.each do |product|
          product.skus.each do |sku|
            expect(sku.size.name).to eq 'M'
          end
        end
      end

      example '品番:p0001 カラー:ネイビー -> ホワイト' do
        navy_color_products.each do |product|
          products_repo.update_sku(product, color: white_color)
        end

        expect(white_color_skus.count).to eq 6
        expect(navy_color_products.count).to eq 0

        white_color_products.each do |product|
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
        create_full_lineup
      end

      example '全件削除' do
        products_repo.destroy_all

        expect(products.count).to eq 0
        expect(skus.count).to eq 0
      end

      example '全件削除' do
        products_repo.delete_all

        expect(products.count).to eq 0
        expect(skus.count).not_to eq 0
      end

      example '品番:p0001' do
        products_repo.destroy(product_p0001)

        expect(products_p0001.count).to eq 0
        expect(skus.count).to eq 6
      end

      example 'サイズ:L' do
        products_repo.destroy_by_size(l_size)

        expect(l_size_products.count).to eq 0
        expect(l_size_skus.count).to eq 0
      end

      example 'カラー:ホワイト' do
        products_repo.destroy_by_color(white_color)

        expect(white_color_products.count).to eq 0
        expect(white_color_skus.count).to eq 0
      end

      example 'サイズ:L カラー：ホワイト' do
        products_repo.destroy_by_size_and_color(l_size, white_color)

        expect(l_size_and_white_color_products.count).to eq 0
        expect(l_size_and_white_color_skus.count).to eq 0
      end
    end
  end
end
