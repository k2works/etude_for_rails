FactoryGirl.define do
  factory :sales_modeling_sales_sale, class: 'SalesModeling::Sales::Sale' do
    type ""
    date "2017-11-08 14:06:27"
    amount "9.99"
    amount_currency "MyString"
    estimate nil
    sales_type_category nil
  end
end
