# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesModeling::Sales::Sale, type: :model do
  let(:normal_type) { create(:customer_type_category, name: '一般') }
  let(:estimate_type) { create(:sales_type_category, name: '見積一般') }
  let(:order_type) { create(:sales_type_category, name: '注文一般') }
  let(:customer_a) { create(:sales_modeling_sales_customer, name: 'A', customer_type_category: normal_type) }
  let(:product_a) { create(:sku_1, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(100)) }
  let(:product_b) { create(:sku_1, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(200)) }
  let(:product_c) { create(:sku_1, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(300)) }

  def build_sales_line(salse, products, quantity)
    products.each do |product|
      n = 1
      sales_line = salse.sales_lines.build
      sales_line.line_number = n
      sales_line.quantity_amount = quantity
      sales_line.quantity_unit = 'SUIT'
      sales_line.unit_sales_price_amount = product.unit_sales_price_amount
      sales_line.unit_sales_price_currency = product.unit_sales_price_currency
      sales_line.sales_price_amount = product.unit_sales_price_amount * sales_line.quantity_amount
      sales_line.sales_price_currency = product.unit_sales_price_currency
      sales_line.sales_modeling_type3_sku = product
      n += 1
    end
  end

  def create_sales(salse, sales_type, customer, products, quantity)
    build_sales_line(salse, products, quantity)

    salse.amount = 0
    salse.date = Date.today
    salse.sales_type_category = sales_type
    salse.sales_modeling_sales_customer = customer
    salse.sales_lines.each do |line|
      salse.amount += line.sales_price_amount
      salse.currency = line.sales_price_currency
    end
  end

  describe '#create' do
    example '一般顧客A向け製品A　売価100円　１着の見積もり' do
      sales_estimate = SalesModeling::Sales::SalesEstimate.new
      products = [product_a]
      create_sales(sales_estimate, estimate_type, customer_a, products, 1)
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

    example '一般顧客A向け製品A　売価100円　2着 製品B 売価200円 2着の見積もり' do
      sales_estimate = SalesModeling::Sales::SalesEstimate.new
      products = [product_a, product_b]
      create_sales(sales_estimate, estimate_type, customer_a, products, 2)
      sales_estimate.save!

      estimate = SalesModeling::Sales::SalesEstimate.first
      expect(estimate.amount).to eq 600
      expect(estimate.sales_lines.first.quantity_amount).to eq 2
      expect(estimate.sales_lines.first.sales_price_amount).to eq 200
      expect(estimate.sales_lines.second.sales_price_amount).to eq 400
    end

    example '一般顧客A向け製品A　売価100円　１着の売上' do
      sales_order = SalesModeling::Sales::SalesOrder.new
      products = [product_a]
      create_sales(sales_order, order_type, customer_a, products, 1)
      sales_order.save!

      estimate = SalesModeling::Sales::SalesOrder.first
      expect(estimate.type).to eq 'SalesModeling::Sales::SalesOrder'
      expect(estimate.sales_type_category.name).to eq '注文一般'
    end

    example '一般顧客A向け製品A　売価100円　2着の売上' do
      sales_order = SalesModeling::Sales::SalesOrder.new
      products = [product_a]
      create_sales(sales_order, order_type, customer_a, products, 2)
      sales_order.save!

      estimate = SalesModeling::Sales::SalesOrder.first
      expect(estimate.amount).to eq 200
      expect(estimate.sales_lines.first.quantity_amount).to eq 2
    end

    example '一般顧客A向け製品A　売価100円　製品B　売価200円 製品C　売価300円 1着の売上' do
      sales_order = SalesModeling::Sales::SalesOrder.new
      products = [product_a, product_b, product_c]
      create_sales(sales_order, order_type, customer_a, products, 1)
      sales_order.save!

      estimate = SalesModeling::Sales::SalesOrder.first
      expect(estimate.amount).to eq 600
      expect(estimate.currency).to eq 'JPY'
    end
  end

  describe '#select' do
  end

  describe '#update' do
  end

  describe '#delete' do
  end
end
