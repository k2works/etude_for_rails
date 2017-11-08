FactoryGirl.define do
  factory :sku_1, class: 'SalesModeling::Type3::Sku' do
    unit_purchase_price SalesModeling::Price::UnitPurchasePrice.new(100)
    unit_sales_price SalesModeling::Price::UnitPurchasePrice.new(200)
    association :sales_modeling_type3_product, factory: :product_1
    size_category
    color_category
  end
end
