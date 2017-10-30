FactoryGirl.define do
  factory :sales_modeling_product, class: 'SalesModeling::Product' do
    code '1'
    name 'Product'
    sales_modeling_size
    sales_modeling_color
    sales_modeling_product_category
    unit_purchase_price 0
    unit_sales_price 0
  end
end
