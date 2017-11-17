# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesModeling::Purchase::Order, type: :model do
  let(:regular_type) { create(:order_type_category, name: '定期発注') }
  let(:supplier_a) { create(:supplier_a, name: 'A') }
  let(:product_a) { create(:sku_1, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(100)) }
  let(:product_b) { create(:sku_2, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(200)) }
  let(:product_c) { create(:sku_3, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(300)) }
  let(:a_suit) { SalesModeling::Quantity.new(1, 'SUIT') }

  describe '#create' do
    example '仕入先Aから製品Aを１着定期発注' do
      params = {
        order_date: Date.today,
        scheduled_arrival_date: Date.today.advance(weeks: 1),
        sales_modeling_purchase_supplier: supplier_a,
        order_type_category: regular_type
      }
      order = SalesModeling::Purchase::Order.new(params)

      params = {
        sales_modeling_type3_sku: product_a,
        quantity: a_suit
      }
      order_line = order.order_lines.build(params)
      order_line.unit_order_price = SalesModeling::Price::UnitSalesPrice.new(order_line.sales_modeling_type3_sku.unit_sales_price_amount)
      order.order_price = SalesModeling::Price::SalesPrice.new(0)
      sum = SalesModeling::Price::SumPrice.new(order.order_price, order.order_price)
      n = 1
      order.order_lines.each do |line|
        line.line_number = n
        sum = sum.plus(line.order_price)
        order.order_price = sum.reduce
        n += 1
      end
      order.save!

      order = SalesModeling::Purchase::Order.first
      expect(Date.parse(order.order_date.to_s).strftime('%Y-%m-%d %H:%M')).to eq Date.parse(Date.today.to_s).strftime('%Y-%m-%d %H:%M')
      expect(Date.parse(order.scheduled_arrival_date.to_s).strftime('%Y-%m-%d %H:%M')).to eq Date.parse(Date.today.advance(weeks: 1).to_s).strftime('%Y-%m-%d %H:%M')
      expect(order.order_type_category.name).to eq '定期発注'
      expect(order.sales_modeling_purchase_supplier.name).to eq 'A'
      expect(order.amount).to eq 100
      expect(order.currency).to eq 'JPY'
      expect(order.order_lines.first.unit_price_amount).to eq 100
      expect(order.order_lines.first.unit_price_currency).to eq 'JPY'
      expect(order.order_lines.first.price_amount).to eq 100
      expect(order.order_lines.first.price_currency).to eq 'JPY'
      expect(order.order_lines.first.sales_modeling_type3_sku.sales_modeling_type3_product.name).to eq '製品A'
    end

    example '仕入先Aから製品A・B・Cを各１着定期発注' do
      params = {
          order_date: Date.today,
          scheduled_arrival_date: Date.today.advance(weeks: 1),
          sales_modeling_purchase_supplier: supplier_a,
          order_type_category: regular_type
      }
      order = SalesModeling::Purchase::Order.new(params)

      order_line_params = []
      params = {
          sales_modeling_type3_sku: product_a,
          quantity: a_suit
      }
      order_line_params << params
      params = {
          sales_modeling_type3_sku: product_b,
          quantity: a_suit
      }
      order_line_params << params
      params = {
          sales_modeling_type3_sku: product_c,
          quantity: a_suit
      }
      order_line_params << params
      order_line_params.each do |params|
        order_line = order.order_lines.build(params)
        order_line.unit_order_price = SalesModeling::Price::UnitSalesPrice.new(order_line.sales_modeling_type3_sku.unit_sales_price_amount)
        order.order_price = SalesModeling::Price::SalesPrice.new(0)
        sum = SalesModeling::Price::SumPrice.new(order.order_price, order.order_price)
        n = 1
        order.order_lines.each do |line|
          line.line_number = n
          sum = sum.plus(line.order_price)
          order.order_price = sum.reduce
          n += 1
        end
        order.save!
      end

      order = SalesModeling::Purchase::Order.first
      expect(Date.parse(order.order_date.to_s).strftime('%Y-%m-%d %H:%M')).to eq Date.parse(Date.today.to_s).strftime('%Y-%m-%d %H:%M')
      expect(Date.parse(order.scheduled_arrival_date.to_s).strftime('%Y-%m-%d %H:%M')).to eq Date.parse(Date.today.advance(weeks: 1).to_s).strftime('%Y-%m-%d %H:%M')
      expect(order.order_type_category.name).to eq '定期発注'
      expect(order.sales_modeling_purchase_supplier.name).to eq 'A'
      expect(order.amount).to eq 600
      expect(order.currency).to eq 'JPY'
      expect(order.order_lines.first.unit_price_amount).to eq 100
      expect(order.order_lines.first.unit_price_currency).to eq 'JPY'
      expect(order.order_lines.first.price_amount).to eq 100
      expect(order.order_lines.first.price_currency).to eq 'JPY'
      expect(order.order_lines.first.sales_modeling_type3_sku.sales_modeling_type3_product.name).to eq '製品A'
      expect(order.order_lines.second.unit_price_amount).to eq 200
      expect(order.order_lines.second.unit_price_currency).to eq 'JPY'
      expect(order.order_lines.second.price_amount).to eq 200
      expect(order.order_lines.second.price_currency).to eq 'JPY'
      expect(order.order_lines.second.sales_modeling_type3_sku.sales_modeling_type3_product.name).to eq '製品B'
      expect(order.order_lines.third.unit_price_amount).to eq 300
      expect(order.order_lines.third.unit_price_currency).to eq 'JPY'
      expect(order.order_lines.third.price_amount).to eq 300
      expect(order.order_lines.third.price_currency).to eq 'JPY'
      expect(order.order_lines.third.sales_modeling_type3_sku.sales_modeling_type3_product.name).to eq '製品C'
    end
  end
  describe '#select' do
  end
  describe '#update' do
  end
  describe '#delete' do
  end
end
