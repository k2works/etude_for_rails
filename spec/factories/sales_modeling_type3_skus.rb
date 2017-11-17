FactoryGirl.define do
  factory :sku_1, class: 'SalesModeling::Type3::Sku' do
    unit_purchase_price SalesModeling::Price::UnitPurchasePrice.new(100)
    unit_sales_price SalesModeling::Price::UnitPurchasePrice.new(200)
    association :sales_modeling_type3_product, factory: :product_1
    size_category
    color_category
  end

  factory :sku_2, class: 'SalesModeling::Type3::Sku' do
    unit_purchase_price SalesModeling::Price::UnitPurchasePrice.new(200)
    unit_sales_price SalesModeling::Price::UnitPurchasePrice.new(400)
    association :sales_modeling_type3_product, factory: :product_2
    size_category
    color_category
  end

  factory :sku_3, class: 'SalesModeling::Type3::Sku' do
    unit_purchase_price SalesModeling::Price::UnitPurchasePrice.new(300)
    unit_sales_price SalesModeling::Price::UnitPurchasePrice.new(600)
    association :sales_modeling_type3_product, factory: :product_3
    size_category
    color_category
  end
end
