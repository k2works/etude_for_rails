FactoryGirl.define do
  factory :sales_modeling_purchase_stock_line, class: 'SalesModeling::Purchase::StockLine' do
    line_number 1
    quantity_amount "9.99"
    quantity_unit "MyString"
    unit_price_amount "9.99"
    unit_price_currency "MyString"
    price_amount "9.99"
    price_currency "MyString"
    sales_modeling_purchase_stocks nil
  end
end
