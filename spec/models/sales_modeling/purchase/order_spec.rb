# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesModeling::Purchase::Order, type: :model do
  let(:regular_type) { create(:order_type_category, name: '定期発注') }
  let(:supplier_a) { create(:supplier_a, name: 'A') }
  let(:product_a) { create(:sku_1, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(100)) }
  let(:product_b) { create(:sku_2, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(200)) }
  let(:product_c) { create(:sku_3, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(300)) }
  let(:a_suit) { SalesModeling::Quantity.new(1, 'SUIT') }
  let(:orders_repo) { SalesModeling::OrderRepo.new }
  let(:order_a_params) do
    {
      order_params: {
        order_date: Date.today,
        scheduled_arrival_date: Date.today.advance(weeks: 1),
        sales_modeling_purchase_supplier: supplier_a,
        order_type_category: regular_type
      },
      order_line_params: [{
        sales_modeling_type3_sku: product_a,
        quantity: a_suit
      }]
    }
  end
  let(:order_abc_params) do
    {
      order_params: {
        order_date: Date.today,
        scheduled_arrival_date: Date.today.advance(weeks: 1),
        sales_modeling_purchase_supplier: supplier_a,
        order_type_category: regular_type
      },
      order_line_params: [
        {
          sales_modeling_type3_sku: product_a,
          quantity: a_suit
        },
        {
          sales_modeling_type3_sku: product_b,
          quantity: a_suit
        },
        {
          sales_modeling_type3_sku: product_c,
          quantity: a_suit
        }
      ]
    }
  end

  describe '#create' do
    example '仕入先Aから製品Aを１着定期発注' do
      orders_repo.save(order_a_params)

      order = orders_repo.select_first
      expect(Date.parse(order.order_date.to_s).strftime('%Y-%m-%d %H:%M')).to eq Date.parse(Date.today.to_s).strftime('%Y-%m-%d %H:%M')
      expect(Date.parse(order.scheduled_arrival_date.to_s).strftime('%Y-%m-%d %H:%M')).to eq Date.parse(Date.today.advance(weeks: 1).to_s).strftime('%Y-%m-%d %H:%M')
      expect(order.order_type_category.name).to eq '定期発注'
      expect(order.sales_modeling_purchase_supplier.name).to eq 'A'
      expect(order.amount).to eq 100
      expect(order.currency).to eq 'JPY'
      expect(order.lines.first.unit_price_amount).to eq 100
      expect(order.lines.first.unit_price_currency).to eq 'JPY'
      expect(order.lines.first.price_amount).to eq 100
      expect(order.lines.first.price_currency).to eq 'JPY'
      expect(order.lines.first.sales_modeling_type3_sku.sales_modeling_type3_product.name).to eq '製品A'
    end

    example '仕入先Aから製品A・B・Cを各１着定期発注' do
      orders_repo.save(order_abc_params)

      order = orders_repo.select_first
      expect(Date.parse(order.order_date.to_s).strftime('%Y-%m-%d %H:%M')).to eq Date.parse(Date.today.to_s).strftime('%Y-%m-%d %H:%M')
      expect(Date.parse(order.scheduled_arrival_date.to_s).strftime('%Y-%m-%d %H:%M')).to eq Date.parse(Date.today.advance(weeks: 1).to_s).strftime('%Y-%m-%d %H:%M')
      expect(order.order_type_category.name).to eq '定期発注'
      expect(order.sales_modeling_purchase_supplier.name).to eq 'A'
      expect(order.amount).to eq 600
      expect(order.currency).to eq 'JPY'
      expect(order.lines.first.unit_price_amount).to eq 100
      expect(order.lines.first.unit_price_currency).to eq 'JPY'
      expect(order.lines.first.price_amount).to eq 100
      expect(order.lines.first.price_currency).to eq 'JPY'
      expect(order.lines.first.sales_modeling_type3_sku.sales_modeling_type3_product.name).to eq '製品A'
      expect(order.lines.second.unit_price_amount).to eq 200
      expect(order.lines.second.unit_price_currency).to eq 'JPY'
      expect(order.lines.second.price_amount).to eq 200
      expect(order.lines.second.price_currency).to eq 'JPY'
      expect(order.lines.second.sales_modeling_type3_sku.sales_modeling_type3_product.name).to eq '製品B'
      expect(order.lines.third.unit_price_amount).to eq 300
      expect(order.lines.third.unit_price_currency).to eq 'JPY'
      expect(order.lines.third.price_amount).to eq 300
      expect(order.lines.third.price_currency).to eq 'JPY'
      expect(order.lines.third.sales_modeling_type3_sku.sales_modeling_type3_product.name).to eq '製品C'
    end
  end
  describe '#select' do
  end
  describe '#update' do
  end
  describe '#delete' do
  end
end
