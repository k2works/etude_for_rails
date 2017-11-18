# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesModeling::Purchase::Warehouse, type: :model do
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
  let(:warehouse_type) { create(:warehouse_type_category, name:'社内')}

  describe '#create' do
    example '発注Aが倉庫Aに入庫' do
      create_order_a
      orders_repo.select_first
      params = {
        code: '1',
        name: '倉庫A',
        warehouse_type_category: warehouse_type,
        sales_modeling_purchase_order: select_order_a
      }
      warehouse = SalesModeling::Purchase::Warehouse.new(params)
      warehouse.save!

      warehouse = SalesModeling::Purchase::Warehouse.first
      expect(warehouse.code).to eq '1'
      expect(warehouse.name).to eq '倉庫A'
      expect(warehouse.warehouse_type_category.name).to eq '社内'
      expect(Date.parse(warehouse.sales_modeling_purchase_order.order_date.to_s).strftime('%Y-%m-%d %H:%M')).to eq Date.parse(Date.today.to_s).strftime('%Y-%m-%d %H:%M')
      expect(Date.parse(warehouse.sales_modeling_purchase_order.scheduled_arrival_date.to_s).strftime('%Y-%m-%d %H:%M')).to eq Date.parse(Date.today.advance(weeks: 1).to_s).strftime('%Y-%m-%d %H:%M')
      expect(warehouse.sales_modeling_purchase_order.order_type_category.name).to eq '定期発注'
      expect(warehouse.sales_modeling_purchase_order.sales_modeling_purchase_supplier.name).to eq 'A'
      expect(warehouse.sales_modeling_purchase_order.amount).to eq 100
      expect(warehouse.sales_modeling_purchase_order.currency).to eq 'JPY'
    end
  end
  describe '#select' do
  end
  describe '#update' do
  end
  describe '#delete' do
  end
end
