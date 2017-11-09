# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesModeling::Sales::Sale, type: :model do
  let(:normal_type) { create(:customer_type_category, name: '一般') }
  let(:estimate_type) { create(:sales_type_category, name: '見積一般') }
  let(:order_type) { create(:sales_type_category, name: '注文一般') }
  let(:customer_a) { create(:sales_modeling_sales_customer, name: 'A', customer_type_category: normal_type) }
  let(:product_a) { create(:sku_1 ,unit_sales_price:SalesModeling::Price::UnitPurchasePrice.new(100)) }

  describe '#create' do
    example '一般顧客A向け製品A　売価100円　１着の見積もり' do
      sales_estimate = SalesModeling::Sales::SalesEstimate.new

      sales_estimate_line = sales_estimate.sales_lines.build
      sales_estimate_line.line_number = 1
      sales_estimate_line.quantity_amount = 1
      sales_estimate_line.quantity_unit='SUIT'
      sales_estimate_line.unit_sales_price_amount = product_a.unit_sales_price_amount
      sales_estimate_line.unit_sales_price_currency = product_a.unit_sales_price_currency
      sales_estimate_line.sales_price_amount = product_a.unit_sales_price_amount * sales_estimate_line.quantity_amount
      sales_estimate_line.sales_price_currency = product_a.unit_sales_price_currency
      sales_estimate_line.sales_modeling_type3_sku = product_a

      sales_estimate.amount = 0
      sales_estimate.date = Date.today
      sales_estimate.sales_type_category = estimate_type
      sales_estimate.sales_modeling_sales_customer = customer_a
      sales_estimate.sales_lines.each do |line|
        sales_estimate.amount += line.sales_price_amount
        sales_estimate.currency = line.sales_price_currency
      end

      sales_estimate.save!

      estimate = SalesModeling::Sales::SalesEstimate.first
      expect(estimate.type).to eq 'SalesModeling::Sales::SalesEstimate'

      expect(Date.today(estimate.date)).to eq Date.today
      expect(estimate.amount).to eq 100
      expect(estimate.currency).to eq 'JPY'
      expect(estimate.sales_modeling_sales_customer.name).to eq 'A'
      expect(estimate.sales_type_category.name).to eq '見積一般'
      expect(estimate.sales_lines.first.line_number).to eq 1
      expect(estimate.sales_lines.first.quantity_amount).to eq 1
      expect(estimate.sales_lines.first.quantity_unit).to eq 'SUIT'
      expect(estimate.sales_lines.first.sales_price_amount).to eq 100
      expect(estimate.sales_lines.first.sales_price_currency).to eq 'JPY'
      expect(estimate.sales_lines.first.sales_modeling_type3_sku.sales_modeling_type3_product.name).to eq '製品A'
    end

    example '一般顧客A向け製品A　売価100円　１着の売上' do
      sales_order = SalesModeling::Sales::SalesOrder.new

      sales_order_line = sales_order.sales_lines.build
      sales_order_line.line_number = 1
      sales_order_line.quantity_amount = 1
      sales_order_line.quantity_unit='着'
      sales_order_line.unit_sales_price_amount = product_a.unit_sales_price_amount
      sales_order_line.unit_sales_price_currency = product_a.unit_sales_price_currency
      sales_order_line.sales_price_amount = product_a.unit_sales_price_amount * sales_order_line.quantity_amount
      sales_order_line.sales_price_currency = product_a.unit_sales_price_currency
      sales_order_line.sales_modeling_type3_sku = product_a

      sales_order.amount = 0
      sales_order.date = Date.today
      sales_order.sales_type_category = order_type
      sales_order.sales_modeling_sales_customer = customer_a
      sales_order.sales_lines.each do |line|
        sales_order.amount += line.sales_price_amount
        sales_order.currency = line.sales_price_currency
      end

      sales_order.save!

      estimate = SalesModeling::Sales::SalesOrder.first
      expect(estimate.type).to eq 'SalesModeling::Sales::SalesOrder'
      expect(estimate.sales_type_category.name).to eq '注文一般'
    end
  end

  describe '#select' do
  end

  describe '#update' do
  end

  describe '#delete' do
  end
end
