# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesModeling::Domain::Purchase::Warehouse, type: :model do
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
  let(:create_order_a) { orders_repo.save(order_a_params) }
  let(:select_order_a) { orders_repo.select_first }
  let(:warehouses_repo) { SalesModeling::WarehouseRepo.new }
  let(:warehouse_type) { create(:warehouse_type_category, name: '社内') }
  let(:warehouse) { warehouses_repo.select_first }
  let(:order_a_in_warehouse_params) do
    {
      code: '1',
      name: '倉庫A',
      warehouse_type_category: warehouse_type,
      sales_modeling_purchase_order: select_order_a
    }
  end

  let(:order_b_params) do
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
  let(:create_order_b) { orders_repo.save(order_b_params) }
  let(:order_b) { orders_repo.select_first }
  let(:stocks_repo) { SalesModeling::StocksRepo.new }
  let(:stock_order_a_params) do
    {
      stock_params: {
        arrival_date: Date.today.advance(weeks: 1),
        acceptance_date: Date.today.advance(weeks: 1),
        sales_modeling_purchase_order: order_b,
        stock_type_category: regular_type
      },
      stock_line_params: [
        {
          sales_modeling_type3_sku: product_a,
          quantity: a_suit
        }
      ]
    }
  end
  let(:stock_order_b_params) do
    {
      stock_params: {
        arrival_date: Date.today.advance(weeks: 1),
        acceptance_date: Date.today.advance(weeks: 1),
        sales_modeling_purchase_order: order_b,
        stock_type_category: regular_type
      },
      stock_line_params: [
        {
          sales_modeling_type3_sku: product_b,
          quantity: a_suit
        }
      ]
    }
  end
  let(:stock_order_c_params) do
    {
      stock_params: {
        arrival_date: Date.today.advance(weeks: 1),
        acceptance_date: Date.today.advance(weeks: 1),
        sales_modeling_purchase_order: order_b,
        stock_type_category: regular_type
      },
      stock_line_params: [
        {
          sales_modeling_type3_sku: product_c,
          quantity: a_suit
        }
      ]
    }
  end
  let(:create_stock_a) { stocks_repo.save(stock_order_a_params) }
  let(:create_stock_b) { stocks_repo.save(stock_order_b_params) }
  let(:create_stock_c) { stocks_repo.save(stock_order_c_params) }
  let(:stock_a) { stocks_repo.select_first }
  let(:stock_b) { stocks_repo.select_second }
  let(:stock_c) { stocks_repo.select_third }

  let(:stock_a_in_warehouse_params) do
    {
        code: '1',
        name: '倉庫A',
        warehouse_type_category: warehouse_type,
        sales_modeling_purchase_stock: stock_a
    }
  end
  let(:stock_b_in_warehouse_params) do
    {
      code: '2',
      name: '倉庫B',
      warehouse_type_category: warehouse_type,
      sales_modeling_purchase_stock: stock_b
    }
  end
  let(:stock_c_in_warehouse_params) do
    {
      code: '3',
      name: '倉庫C',
      warehouse_type_category: warehouse_type,
      sales_modeling_purchase_stock: stock_c
    }
  end
  let(:warehouse_a) { warehouses_repo.select_first }
  let(:warehouse_b) { warehouses_repo.select_second }
  let(:warehouse_c) { warehouses_repo.select_third }

  describe '#create' do
    example '発注Aが倉庫Aに入庫' do
      create_order_a
      warehouses_repo.save(order_a_in_warehouse_params)

      expect(warehouse.code).to eq '1'
      expect(warehouse.name).to eq '倉庫A'
      expect(warehouse.warehouse_type_category.name).to eq '社内'
      expect(Date.parse(warehouse.sales_modeling_purchase_order.order_date.to_s).strftime('%Y-%m-%d %H:%M')).to eq Date.parse(Date.today.to_s).strftime('%Y-%m-%d %H:%M')
      expect(Date.parse(warehouse.sales_modeling_purchase_order.scheduled_arrival_date.to_s).strftime('%Y-%m-%d %H:%M')).to eq Date.parse(Date.today.advance(weeks: 1).to_s).strftime('%Y-%m-%d %H:%M')
      expect(warehouse.sales_modeling_purchase_order.order_type_category.name).to eq '定期発注'
      expect(warehouse.sales_modeling_purchase_order.sales_modeling_purchase_supplier.name).to eq 'A'
      expect(warehouse.sales_modeling_purchase_order.amount).to eq 100
      expect(warehouse.sales_modeling_purchase_order.currency).to eq 'JPY'
      expect(select_order_a.warehouses.first).to eq warehouse
    end

    example '発注Bが倉庫A・B・Cに入庫' do
      create_order_b
      create_stock_a
      create_stock_b
      create_stock_c
      warehouses_repo.save(stock_a_in_warehouse_params)
      warehouses_repo.save(stock_b_in_warehouse_params)
      warehouses_repo.save(stock_c_in_warehouse_params)

      expect(stocks_repo.select_all.count).to eq 3
      expect(stock_a.warehouse.name).to eq '倉庫A'
      expect(stock_b.warehouse.name).to eq '倉庫B'
      expect(stock_c.warehouse.name).to eq '倉庫C'
      expect(stock_a.warehouse).to eq warehouse_a
      expect(stock_b.warehouse).to eq warehouse_b
      expect(stock_c.warehouse).to eq warehouse_c
      expect(order_b.warehouses.count).to eq 3
      expect(order_b.warehouses.first).to eq warehouse_a
      expect(order_b.warehouses.second).to eq warehouse_b
      expect(order_b.warehouses.third).to eq warehouse_c
    end
  end
  describe '#select' do
  end
  describe '#update' do
  end
  describe '#delete' do
  end
end
