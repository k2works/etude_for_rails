# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesModeling::Domain::Purchase::OrderService do
  let(:simple_type) { create(:order_type_category, name: '簡易') }
  let(:regular_type) { create(:order_type_category, name: '定期') }
  let(:fix_size_type) { create(:order_type_category, name: '定量') }
  let(:supplier_a) { create(:supplier_a, name: 'A') }
  let(:product_a) { create(:sku_1, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(100)) }
  let(:product_b) { create(:sku_2, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(200)) }
  let(:product_c) { create(:sku_3, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(300)) }
  let(:a_suit) { SalesModeling::Quantity.new(1, 'SUIT') }
  let(:orders_repo) { SalesModeling::OrderRepo.new }
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

  describe '#simple_order' do
    example '仕入先Aから製品Aを簡易発注' do
      order_service = SalesModeling::Domain::Purchase::OrderService.new
      order_service.simple_order(simple_order_params)
      expect(orders_repo.select_all.count).to eq 1
    end
  end

  describe '#regular_order' do
    example '仕入先Aから製品Aを定期発注' do
      order_service = SalesModeling::Domain::Purchase::OrderService.new
      order_service.regular_order(regular_order_params)
      expect(orders_repo.select_all.count).to eq 1
    end
  end

  describe '#fix_size_order' do
    example '仕入先Aから製品Aを定量発注' do
      order_service = SalesModeling::Domain::Purchase::OrderService.new
      order_service.fix_size_order(fix_size_order_params)
      expect(orders_repo.select_all.count).to eq 1
    end
  end
end
