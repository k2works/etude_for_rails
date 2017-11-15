# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalesModeling::Domain::Sales, type: :model do
  let(:normal_type) { create(:customer_type_category, name: '一般') }
  let(:special_type) { create(:customer_type_category, name: '特別') }
  let(:estimate_type) { create(:sales_type_category, name: '見積一般') }
  let(:order_type) { create(:sales_type_category, name: '注文一般') }
  let(:customer_a) { create(:sales_modeling_sales_customer, name: 'A', customer_type_category: normal_type) }
  let(:customer_b) { create(:sales_modeling_sales_customer, name: 'B', customer_type_category: special_type) }
  let(:product_a) { create(:sku_1, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(100)) }
  let(:product_b) { create(:sku_1, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(200)) }
  let(:product_c) { create(:sku_1, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(300)) }
  let(:sales_repo) { SalesModeling::SalesRepo.new }
  let(:select_first_sales_estimate) { sales_repo.select_first_sales_estimate }
  let(:select_first_sales_order) { sales_repo.select_first_sales_order }
  let(:select_third_sales_estimate) { sales_repo.select_third_sales_estimate }
  let(:select_all) { sales_repo.select_all }
  let(:select_all_sales_line) { sales_repo.select_all_sales_line }
  let(:select_all_estimate) { sales_repo.select_all_estimate }
  let(:select_all_order) { sales_repo.select_all_order }
  let(:destroy_all) { sales_repo.destroy_all }
  let(:destroy_all_estimate) { sales_repo.destroy_all_estimate }
  let(:destroy_all_order) { sales_repo.destroy_all_order }
  let(:sales_estimate_a) {create(:sales_estimate,sales_type_category: estimate_type) }
  let(:sales_estimate_b) {create(:sales_estimate,sales_type_category: estimate_type) }
  let(:sales_estimate_c) {create(:sales_estimate,sales_type_category: estimate_type) }
  let(:sales_order_a) {create(:sales_order,sales_type_category: order_type) }
  let(:sales_order_b) {create(:sales_order,sales_type_category: order_type) }
  let(:sales_order_c) {create(:sales_order,sales_type_category: order_type) }
  let(:a_suit) { SalesModeling::Quantity.new(1,'SUIT')}
  let(:two_suits) { SalesModeling::Quantity.new(2,'SUIT')}


  describe '#create' do
    example '一般顧客A向け製品A　売価100円　１着の見積もり' do
      params = { date: Date.today, sales_type_category: estimate_type, sales_modeling_sales_customer: customer_a }
      sales_estimate = sales_repo.new_sales_estimate(params)
      sales_repo.new_sales_line(sales_estimate, product_a, a_suit)
      sales_repo.save(sales_estimate)

      estimate = select_first_sales_estimate
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
      params = { date: Date.today, sales_type_category: estimate_type, sales_modeling_sales_customer: customer_a }
      sales_estimate = sales_repo.new_sales_estimate(params)
      sales_repo.new_sales_line(sales_estimate, product_a, two_suits)
      sales_repo.new_sales_line(sales_estimate, product_b, two_suits)
      sales_repo.save(sales_estimate)

      estimate = select_first_sales_estimate
      expect(estimate.amount).to eq 600
      expect(estimate.sales_lines.first.quantity_amount).to eq 2
      expect(estimate.sales_lines.first.sales_price_amount).to eq 200
      expect(estimate.sales_lines.second.sales_price_amount).to eq 400
    end

    example '一般顧客A向け製品A　売価100円　１着の売上' do
      params = { date: Date.today, sales_type_category: order_type, sales_modeling_sales_customer: customer_a }
      sales_order = sales_repo.new_sales_order(params)
      sales_repo.new_sales_line(sales_order, product_a, a_suit)
      sales_repo.save(sales_order)

      estimate = select_first_sales_order
      expect(estimate.type).to eq 'SalesModeling::Sales::SalesOrder'
      expect(estimate.sales_type_category.name).to eq '注文一般'
    end

    example '一般顧客A向け製品A　売価100円　2着の売上' do
      params = { date: Date.today, sales_type_category: order_type, sales_modeling_sales_customer: customer_a }
      sales_order = sales_repo.new_sales_order(params)
      sales_repo.new_sales_line(sales_order, product_a, two_suits)
      sales_repo.save(sales_order)

      estimate = select_first_sales_order
      expect(estimate.amount).to eq 200
      expect(estimate.sales_lines.first.quantity_amount).to eq 2
    end

    example '一般顧客A向け製品A　売価100円　製品B　売価200円 製品C　売価300円 1着の売上' do
      params = { date: Date.today, sales_type_category: order_type, sales_modeling_sales_customer: customer_a }
      sales_order = sales_repo.new_sales_order(params)
      sales_repo.new_sales_line(sales_order, product_a, a_suit)
      sales_repo.new_sales_line(sales_order, product_b, a_suit)
      sales_repo.new_sales_line(sales_order, product_c, a_suit)
      sales_repo.save(sales_order)

      estimate = select_first_sales_order
      expect(estimate.amount).to eq 600
      expect(estimate.currency).to eq 'JPY'
    end

    example '特別顧客B向け製品A　売価100円　１着の見積もり 売価75円 ２着の売上' do
      params = { date: Date.today, sales_type_category: estimate_type, sales_modeling_sales_customer: customer_b }
      sales_estimate = sales_repo.new_sales_estimate(params)

      sales_repo.new_sales_line(sales_estimate, product_a, a_suit)
      sales_repo.save(sales_estimate)

      sales_estimate = select_first_sales_estimate
      params = { date: Date.today, sales_type_category: sales_estimate.sales_type_category, sales_modeling_sales_customer: sales_estimate.sales_modeling_sales_customer }
      sales_order = sales_repo.new_sales_order(params)
      product_a.unit_sales_price = SalesModeling::Price::UnitPurchasePrice.new(75)
      sales_repo.new_sales_line(sales_order, product_a, two_suits)
      sales_repo.save(sales_order, sales_estimate)

      sales_estimate = select_first_sales_estimate
      sales_order = select_first_sales_order
      expect(customer_b.sales_estimates.first).to eq sales_estimate
      expect(customer_b.sales_sales_orders.first).to eq sales_order
      expect(sales_order.sales_estimates.first).to eq sales_estimate
      expect(sales_estimate.sales_order).to eq sales_order
      expect(sales_order.amount).to eq 150
      expect(sales_order.sales_lines.first.quantity_amount).to eq 2
      expect(sales_order.sales_lines.first.unit_sales_price_amount).to eq 75
      expect(sales_order.sales_lines.first.sales_price_amount).to eq 150
    end

    example '特別顧客B向け製品A　見積もり３回 ３回目の見積もりで売上' do
      customer = customer_b
      product_a_1 = create(:sku_1, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(100))
      product_a_2 = create(:sku_1, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(75))
      product_a_3 = create(:sku_1, unit_sales_price: SalesModeling::Price::UnitPurchasePrice.new(50))
      estimats = [product_a_1, product_a_2, product_a_3]
      estimats.each do |estimate|
        params = { date: Date.today, sales_type_category: estimate_type, sales_modeling_sales_customer: customer }
        sales_estimate = sales_repo.new_sales_estimate(params)
        sales_repo.new_sales_line(sales_estimate, estimate, a_suit)
        sales_repo.save(sales_estimate)
      end

      sales_estimate = select_third_sales_estimate
      params = { date: Date.today, sales_type_category: sales_estimate.sales_type_category, sales_modeling_sales_customer: sales_estimate.sales_modeling_sales_customer }
      sales_order = sales_repo.new_sales_order(params)
      sales_repo.copy_sales_line(sales_order, sales_estimate)
      sales_repo.save(sales_order, sales_estimate)

      sales_estimate = select_third_sales_estimate
      sales_order = select_first_sales_order
      expect(customer.sales_sales_orders.first.sales_estimates.count).to eq 1
      expect(sales_order.sales_estimates.first).to eq sales_estimate
      expect(sales_estimate.sales_order).to eq sales_order
      expect(sales_order.amount).to eq 50
      expect(sales_order.sales_lines.first.quantity_amount).to eq 1
      expect(sales_order.sales_lines.first.unit_sales_price_amount).to eq 50
      expect(sales_order.sales_lines.first.sales_price_amount).to eq 50
    end
  end

  describe '#select' do
    before(:each) do
      sales_estimate_a
      sales_estimate_b
      sales_estimate_c
      sales_order_a
      sales_order_b
      sales_order_c
    end

    example '総件数' do
      expect(select_all.count).to eq 6
    end

    example '見積もり件数' do
      expect(select_all_estimate.count).to eq 3
    end

    example '売上件数' do
      expect(select_all_order.count).to eq 3
    end
  end

  describe '#update' do
    before(:each) do
      params = { date: Date.today, sales_type_category: estimate_type, sales_modeling_sales_customer: customer_a }
      sales_estimate = sales_repo.new_sales_estimate(params)
      sales_repo.new_sales_line(sales_estimate, product_a, a_suit)
      sales_repo.save(sales_estimate)
    end

    example '見積明細金額更新' do
      sales_estimate = select_first_sales_estimate
      sales_line = sales_estimate.sales_lines.first
      sales_repo.save_sales_line(sales_estimate, sales_line,{unit_sales_price_amount: 1000 } )

      sales_estimate = select_first_sales_estimate
      expect(sales_estimate.amount).to eq 1000
    end

    example '見積明細数量更新' do
      sales_estimate = select_first_sales_estimate
      sales_line = sales_estimate.sales_lines.first
      sales_repo.save_sales_line(sales_estimate, sales_line, {quantity: two_suits } )

      sales_estimate = select_first_sales_estimate
      expect(sales_estimate.amount).to eq 200
    end
  end

  describe '#delete' do
    before(:each) do
      sales_estimate_a
      sales_estimate_b
      sales_estimate_c
      sales_order_a
      sales_order_b
      sales_order_c

      sales_repo.new_sales_line(sales_estimate_a, product_a, a_suit)
      sales_repo.save(sales_estimate_a)
      sales_repo.new_sales_line(sales_order_a, product_a, a_suit)
      sales_repo.save(sales_order_a)
    end

    example '全件削除' do
      destroy_all
      expect(select_all.count).to eq 0
      expect(select_all_sales_line.count).to eq 0
    end

    example '見積もり全件削除' do
      destroy_all_estimate
      expect(select_all_estimate.count).to eq 0
      expect(select_all.count).to eq 3
      expect(select_all_sales_line.count).to eq 1
    end

    example '見積もり1件削除' do
      sales_repo.destroy(sales_estimate_a)
      expect(select_all_estimate.count).to eq 2
      expect(select_all.count).to eq 5
      expect(select_all_sales_line.count).to eq 1
    end

    example '売上全件削除' do
      destroy_all_order
      expect(select_all_order.count).to eq 0
      expect(select_all.count).to eq 3
      expect(select_all_sales_line.count).to eq 1
    end

    example '売上1件削除' do
      sales_repo.destroy(sales_order_a)
      expect(select_all_order.count).to eq 2
      expect(select_all.count).to eq 5
      expect(select_all_sales_line.count).to eq 1
    end

  end
end
