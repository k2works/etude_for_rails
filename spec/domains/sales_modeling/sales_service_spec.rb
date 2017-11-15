# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesModeling::Domain::Sales::SalesService do
  let(:estimate_type) { create(:sales_estimate_type_category, name: '見積') }
  let(:order_type) { create(:sales_order_type_category, name: '注文') }
  let(:normal_type) { create(:customer_type_category, name: '一般') }
  let(:special_type) { create(:customer_type_category, name: '特別') }
  let(:customer_a) { create(:sales_modeling_sales_customer, name: 'A', customer_type_category: normal_type) }
  let(:customer_b) { create(:sales_modeling_sales_customer, name: 'B', customer_type_category: special_type) }
  let(:product_a) { create(:sku_1, code:'p0001-00001', unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(100)) }
  let(:product_b) { create(:sku_1, code:'p0001-00002', unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(200)) }
  let(:product_c) { create(:sku_1, code:'p0001-00003', unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(300)) }
  let(:a_suit) { SalesModeling::Quantity.new(1, 'SUIT') }
  let(:two_suits) { SalesModeling::Quantity.new(2, 'SUIT') }
  let(:three_suits) { SalesModeling::Quantity.new(3, 'SUIT') }
  let(:ten_suits) { SalesModeling::Quantity.new(10, 'SUIT') }
  let(:service) { SalesModeling::Domain::Sales::SalesService.new }

  describe '#present_estimate' do
    example '一般顧客A向け製品Aの見積もり提示' do
      estimate_type
      products = [{ sku_code: product_a.sku_code.code, amount: a_suit.amount, unit: a_suit.unit }]
      estimate = service.present_estimate(customer_a, products)

      expect(Date.today(estimate.date)).to eq Date.today
      expect(estimate.amount).to eq 100
      expect(estimate.currency).to eq 'JPY'
      expect(estimate.sales_modeling_sales_customer.name).to eq 'A'
      expect(estimate.sales_type_category.name).to eq '見積'
      expect(estimate.sales_lines.first.line_number).to eq 1
      expect(estimate.sales_lines.first.quantity_amount).to eq 1
      expect(estimate.sales_lines.first.quantity_unit).to eq 'SUIT'
      expect(estimate.sales_lines.first.sales_price_amount).to eq 100
      expect(estimate.sales_lines.first.sales_price_currency).to eq 'JPY'
      expect(estimate.sales_lines.first.sales_modeling_type3_sku.sales_modeling_type3_product.name).to eq '製品A'
    end

    example '一般顧客A向け製品Aの１０着見積もり提示' do
      estimate_type
      products = [{ sku_code: product_a.sku_code.code, amount: ten_suits.amount, unit: ten_suits.unit }]
      estimate = service.present_estimate(customer_a, products)

      expect(estimate.amount).to eq 1000
      expect(estimate.currency).to eq 'JPY'
      expect(estimate.sales_lines.first.quantity_amount).to eq 10
      expect(estimate.sales_lines.first.quantity_unit).to eq 'SUIT'
      expect(estimate.sales_lines.first.sales_price_amount).to eq 1000
      expect(estimate.sales_lines.first.sales_price_currency).to eq 'JPY'
    end

    example '特別顧客B向け製品A,B,Cの見積もり提示' do
      estimate_type
      products = [
          { sku_code: product_a.sku_code.code, amount: a_suit.amount, unit: a_suit.unit },
          { sku_code: product_b.sku_code.code, amount: a_suit.amount, unit: a_suit.unit },
          { sku_code: product_c.sku_code.code, amount: a_suit.amount, unit: a_suit.unit }
      ]
      estimate = service.present_estimate(customer_b, products)

      expect(estimate.amount).to eq 600
      expect(estimate.currency).to eq 'JPY'
      expect(estimate.sales_modeling_sales_customer.name).to eq 'B'
      expect(estimate.sales_lines.count).to eq 3
    end

  end

  describe '#accept_order' do
    before(:each) do
      estimate_type
      order_type
    end

    example '一般顧客A向け製品Aの注文受諾' do
      products = [{ sku_code: product_a.sku_code.code, amount: a_suit.amount, unit: a_suit.unit }]
      service.present_estimate(customer_a, products)
      order = service.accept_orders(customer_a)

      expect(Date.today(order.date)).to eq Date.today
      expect(order.amount).to eq 100
      expect(order.currency).to eq 'JPY'
      expect(order.sales_modeling_sales_customer.name).to eq 'A'
      expect(order.sales_type_category.name).to eq '注文'
      expect(order.sales_lines.first.line_number).to eq 1
      expect(order.sales_lines.first.quantity_amount).to eq 1
      expect(order.sales_lines.first.quantity_unit).to eq 'SUIT'
      expect(order.sales_lines.first.sales_price_amount).to eq 100
      expect(order.sales_lines.first.sales_price_currency).to eq 'JPY'
      expect(order.sales_lines.first.sales_modeling_type3_sku.sales_modeling_type3_product.name).to eq '製品A'
    end

    example '一般顧客A向け製品Aの見積もり３回実施後注文受諾' do
      products = [{ sku_code: product_a.sku_code.code, amount: a_suit.amount, unit: a_suit.unit }]
      service.present_estimate(customer_a, products)
      products = [{ sku_code: product_a.sku_code.code, amount: two_suits.amount, unit: two_suits.unit }]
      service.present_estimate(customer_a, products)
      products = [{ sku_code: product_a.sku_code.code, amount: three_suits.amount, unit: three_suits.unit }]
      service.present_estimate(customer_a, products)

      order = service.accept_orders(customer_a)

      expect(Date.today(order.date)).to eq Date.today
      expect(order.amount).to eq 300
      expect(order.currency).to eq 'JPY'
      expect(order.sales_modeling_sales_customer.name).to eq 'A'
      expect(order.sales_type_category.name).to eq '注文'
      expect(order.sales_lines.first.line_number).to eq 1
      expect(order.sales_lines.first.quantity_amount).to eq 3
      expect(order.sales_lines.first.quantity_unit).to eq 'SUIT'
      expect(order.sales_lines.first.sales_price_amount).to eq 300
      expect(order.sales_lines.first.sales_price_currency).to eq 'JPY'
      expect(order.sales_lines.first.sales_modeling_type3_sku.sales_modeling_type3_product.name).to eq '製品A'
    end
  end
end
