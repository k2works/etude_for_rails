FactoryGirl.define do
  factory :sales_modeling_purchase_order, class: 'SalesModeling::Purchase::Order' do
    order_date "2017-11-17 14:32:55"
    scheduled_arrival_date "2017-11-17 14:32:55"
    amount "9.99"
    currency "MyString"
    sales_modeling_purchase_suppliers nil
  end
end
