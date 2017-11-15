# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesModeling::Domain::Sales::SalesService do
  let(:estimate_type) { create(:sales_estimate_type_category, name: '見積一般') }
  let(:order_type) { create(:sales_order_type_category, name: '注文一般') }
  let(:normal_type) { create(:customer_type_category, name: '一般') }
  let(:special_type) { create(:customer_type_category, name: '特別') }
  let(:customer_a) { create(:sales_modeling_sales_customer, name: 'A', customer_type_category: normal_type) }
  let(:customer_b) { create(:sales_modeling_sales_customer, name: 'B', customer_type_category: special_type) }
  let(:product_a) { create(:sku_1, code:'p0001-00001', unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(100)) }
  let(:product_b) { create(:sku_1, code:'p0001-00001', unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(200)) }
  let(:product_c) { create(:sku_1, code:'p0001-00001', unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(300)) }
  let(:a_suit) { SalesModeling::Quantity.new(1, 'SUIT') }
  let(:two_suits) { SalesModeling::Quantity.new(2, 'SUIT') }
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
      expect(estimate.sales_type_category.name).to eq '見積一般'
      expect(estimate.sales_lines.first.line_number).to eq 1
      expect(estimate.sales_lines.first.quantity_amount).to eq 1
      expect(estimate.sales_lines.first.quantity_unit).to eq 'SUIT'
      expect(estimate.sales_lines.first.sales_price_amount).to eq 100
      expect(estimate.sales_lines.first.sales_price_currency).to eq 'JPY'
      expect(estimate.sales_lines.first.sales_modeling_type3_sku.sales_modeling_type3_product.name).to eq '製品A'
    end
  end

  describe '#accept_order' do
    example ''
  end
end
