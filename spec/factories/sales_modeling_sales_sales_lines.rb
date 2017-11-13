FactoryGirl.define do
  factory :sales_modeling_sales_sales_line, class: 'SalesModeling::Sales::SalesLine' do
    line_number 1
    quantity_amount "9.99"
    quantity_unit "MyString"
    unit_sales_price_amount "9.99"
    unit_sales_price_currency "MyString"
    sales_price_amount "9.99"
    sales_price_currency "MyString"
    association :sales_modeling_type3_sku, factory: :sku_1
  end

  factory :sales_estimate_line, class: 'SalesModeling::Sales::SalesLine' do
    sequence(:line_number)
    association :sales_modeling_type3_sku, factory: :sku_1
  end
end
