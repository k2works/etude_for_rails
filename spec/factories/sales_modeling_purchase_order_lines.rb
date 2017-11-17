FactoryGirl.define do
  factory :sales_modeling_purchase_order_line, class: 'SalesModeling::Purchase::OrderLine' do
    line_number ""
    quantity_amount "9.99"
    quantity_unit "MyString"
    unit_price_amount "9.99"
    unit_price_currency "MyString"
    price_amount "9.99"
    price_currency "MyString"
    references ""
  end
end
