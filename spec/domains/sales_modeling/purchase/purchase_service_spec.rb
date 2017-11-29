# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesModeling::Domain::Purchase::PurchaseService do
  let(:service) { SalesModeling::Domain::Purchase::PurchaseService.new }

  describe '注文する' do
    let(:simple_type) { create(:simple_order_type_category, name: '簡易') }
    let(:fix_size_type) { create(:fix_size_order_type_category, name: '定量') }
    let(:regular_type) { create(:regular_order_type_category, name: '定期') }
    let(:null_type) { create(:order_type_category, name: '該当なし') }
    let(:supplier_a) { create(:supplier_a, name: 'A') }
    let(:product_a) { create(:sku_1, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(100)) }
    let(:product_b) { create(:sku_2, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(200)) }
    let(:product_c) { create(:sku_3, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(300)) }
    let(:a_suit) { SalesModeling::Quantity.new(1, 'SUIT') }
    let(:orders_repo) { SalesModeling::OrdersRepo.new }
    let(:simple_order_params) do
      {
        order_params: {
          order_date: Date.today,
          scheduled_arrival_date: Date.today.advance(weeks: 1),
          sales_modeling_purchase_supplier: supplier_a,
          order_type_category: simple_type
        },
        order_line_params: [{
          sales_modeling_type3_sku: product_a,
          quantity: a_suit
        }]
      }
    end
    let(:regular_order_params) do
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
    let(:fix_size_order_params) do
      {
        order_params: {
          order_date: Date.today,
          scheduled_arrival_date: Date.today.advance(weeks: 1),
          sales_modeling_purchase_supplier: supplier_a,
          order_type_category: fix_size_type
        },
        order_line_params: [{
          sales_modeling_type3_sku: product_a,
          quantity: a_suit
        }]
      }
    end
    let(:null_order_params) do
      {
        order_params: {
          order_date: Date.today,
          scheduled_arrival_date: Date.today.advance(weeks: 1),
          sales_modeling_purchase_supplier: supplier_a,
          order_type_category: null_type
        },
        order_line_params: [{
          sales_modeling_type3_sku: product_a,
          quantity: a_suit
        }]
      }
    end

    describe '#order_to_supplier' do
      example '仕入先Aから製品Aを簡易発注' do
        service.order_to_supplier(simple_order_params)
        expect(orders_repo.select_all.count).to eq 1
      end

      example '仕入先Aから製品Aを定期発注' do
        service.order_to_supplier(regular_order_params)
        expect(orders_repo.select_all.count).to eq 1
      end

      example '仕入先Aから製品Aを定量発注' do
        service.order_to_supplier(fix_size_order_params)
        expect(orders_repo.select_all.count).to eq 1
      end

      example '該当する発注方式が無い' do
        expect {
          service.order_to_supplier(null_order_params)
        }.to raise_error(RuntimeError, "Unexpected order type_category")
      end
    end
  end

  describe '注文を検収する' do
    let(:regular_type) { create(:regular_order_type_category, name: '定期') }
    let(:supplier_a) { create(:supplier_a, name: 'A') }
    let(:product_a) { create(:sku_1, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(100)) }
    let(:product_b) { create(:sku_2, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(200)) }
    let(:product_c) { create(:sku_3, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(300)) }
    let(:a_suit) { SalesModeling::Quantity.new(1, 'SUIT') }
    let(:orders_repo) { SalesModeling::OrdersRepo.new }
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
    let(:order) { orders_repo.select_first }
    let(:stocks_repo) { SalesModeling::StocksRepo.new }
    let(:stock_order_a_params) do
      {
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
    end
    let(:warehouses_repo) { SalesModeling::WarehouseRepo.new }
    let(:warehouse_type) { create(:warehouse_type_category, name: '社内') }
    let(:stock_a_in_warehouse_params) do
      {
          code: '1',
          name: '倉庫A',
          warehouse_type_category: warehouse_type
      }
    end

    describe '#acceptance_inspection' do
      example '仕入先Aから製品Aを１着定期発注１着を倉庫Aに入庫' do
        create_order_a
        service.acceptance_inspection(stock_order_a_params, stock_a_in_warehouse_params)
        expect(stocks_repo.select_all.count).to eq 1
        expect(warehouses_repo.select_all.count).to eq 1
      end
    end
  end
end
