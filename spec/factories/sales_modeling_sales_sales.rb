FactoryGirl.define do
  factory :sales_modeling_sales_sale, class: 'SalesModeling::Sales::Sale' do
    type ""
    date "2017-11-08 14:06:27"
    amount "9.99"
    currency "MyString"
    association :sales_type_category, factory: :sales_type_category
    association :sales_modeling_sales_customer, factory: :normal_customer
  end

  factory :sales_estimate, class: 'SalesModeling::Sales::SalesEstimate' do
    association :sales_type_category, factory: :sales_type_category
    association :sales_modeling_sales_customer, factory: :normal_customer
  end

  factory :sales_order, class: 'SalesModeling::Sales::SalesOrder' do
    association :sales_type_category, factory: :sales_type_category
    association :sales_modeling_sales_customer, factory: :normal_customer
  end
end
