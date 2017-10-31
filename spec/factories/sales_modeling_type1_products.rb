FactoryGirl.define do
  factory :sales_modeling_type1_product, class: 'SalesModeling::Type1::Product' do
    code SalesModeling::Type1::JANCode.new('1234567890123')
    name 'Product'
    sales_modeling_size
    sales_modeling_color
    sales_modeling_product_category
    unit_purchase_price 0
    unit_sales_price 0
  end
end
