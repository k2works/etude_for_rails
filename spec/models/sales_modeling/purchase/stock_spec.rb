# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesModeling::Purchase::Stock, type: :model do
  let(:regular_type) { create(:order_type_category, name: '定期発注') }
  let(:supplier_a) { create(:supplier_a, name: 'A') }
  let(:product_a) { create(:sku_1, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(100)) }
  let(:product_b) { create(:sku_2, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(200)) }
  let(:product_c) { create(:sku_3, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(300)) }
  let(:a_suit) { SalesModeling::Quantity.new(1, 'SUIT') }
  let(:ten_suites) { SalesModeling::Quantity.new(10, 'SUIT') }
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
        quantity: ten_suites
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
  let(:stocks_repo) { SalesModeling::StocksRepo.new }

  describe '#create' do
    example '仕入先Aから製品Aを１０着定期発注１着入庫' do
      orders_repo.save(order_a_params)
      order = orders_repo.select_first

      stock_order_a_params = {
        stock_params: {
          arrival_date: Date.today.advance(weeks: 1),
          acceptance_date: Date.today.advance(weeks: 1),
          sales_modeling_purchase_order: order,
          stock_type_category: regular_type
        },
        stock_line_params: [{
          sales_modeling_type3_sku: product_a,
          quantity: a_suit
        }]
      }

      stocks_repo.save(stock_order_a_params)
      stock = stocks_repo.select_first

      expect(Date.parse(stock.arrival_date.to_s).strftime('%Y-%m-%d %H:%M')).to eq Date.parse(Date.today.advance(weeks: 1).to_s).strftime('%Y-%m-%d %H:%M')
      expect(Date.parse(stock.acceptance_date.to_s).strftime('%Y-%m-%d %H:%M')).to eq Date.parse(Date.today.advance(weeks: 1).to_s).strftime('%Y-%m-%d %H:%M')
      expect(stock.stock_type_category.name).to eq '定期発注'
      expect(stock.sales_modeling_purchase_supplier.name).to eq 'A'
      expect(stock.lines.first.unit_price_amount).to eq 100
      expect(stock.lines.first.unit_price_currency).to eq 'JPY'
      expect(stock.lines.first.quantity_amount).to eq 1
      expect(stock.lines.first.quantity_unit).to eq 'SUIT'
      expect(stock.lines.first.price_amount).to eq 100
      expect(stock.lines.first.price_currency).to eq 'JPY'
      expect(stock.sales_modeling_purchase_order.amount).to eq 1000
      expect(stock.sales_modeling_purchase_order.currency).to eq 'JPY'
      expect(stock.lines.first.sales_modeling_type3_sku.sales_modeling_type3_product.name).to eq '製品A'
    end

    example '仕入先Aから製品A・B・Cを各１着定期発注 A・B入庫' do
      orders_repo.save(order_abc_params)

      order = orders_repo.select_first

      stock_order_abc_params = {
        stock_params: {
          arrival_date: Date.today.advance(weeks: 1),
          acceptance_date: Date.today.advance(weeks: 1),
          sales_modeling_purchase_order: order,
          stock_type_category: regular_type
        },
        stock_line_params: [
          {
            sales_modeling_type3_sku: product_a,
            quantity: a_suit
          },
          {
            sales_modeling_type3_sku: product_b,
            quantity: a_suit
          }
        ]
      }

      stocks_repo.save(stock_order_abc_params)
      stock = stocks_repo.select_first

      expect(stock.lines.count).to eq 2
      expect(Date.parse(stock.arrival_date.to_s).strftime('%Y-%m-%d %H:%M')).to eq Date.parse(Date.today.advance(weeks: 1).to_s).strftime('%Y-%m-%d %H:%M')
      expect(Date.parse(stock.acceptance_date.to_s).strftime('%Y-%m-%d %H:%M')).to eq Date.parse(Date.today.advance(weeks: 1).to_s).strftime('%Y-%m-%d %H:%M')
      expect(stock.stock_type_category.name).to eq '定期発注'
      expect(stock.sales_modeling_purchase_supplier.name).to eq 'A'
      expect(stock.lines.first.sales_modeling_type3_sku.sales_modeling_type3_product.name).to eq '製品A'
      expect(stock.lines.first.unit_price_amount).to eq 100
      expect(stock.lines.first.unit_price_currency).to eq 'JPY'
      expect(stock.lines.first.quantity_amount).to eq 1
      expect(stock.lines.first.quantity_unit).to eq 'SUIT'
      expect(stock.lines.first.price_amount).to eq 100
      expect(stock.lines.first.price_currency).to eq 'JPY'

      expect(stock.lines.second.sales_modeling_type3_sku.sales_modeling_type3_product.name).to eq '製品B'
      expect(stock.lines.second.unit_price_amount).to eq 200
      expect(stock.lines.second.unit_price_currency).to eq 'JPY'
      expect(stock.lines.second.quantity_amount).to eq 1
      expect(stock.lines.second.quantity_unit).to eq 'SUIT'
      expect(stock.lines.second.price_amount).to eq 200
      expect(stock.lines.second.price_currency).to eq 'JPY'

      expect(stock.sales_modeling_purchase_order.amount).to eq 600
      expect(stock.sales_modeling_purchase_order.currency).to eq 'JPY'
    end
  end
  describe '#select' do
  end
  describe '#update' do
  end
  describe '#delete' do
  end
end
