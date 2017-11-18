FactoryGirl.define do
  factory :sales_modeling_purchase_warehouse, class: 'SalesModeling::Purchase::Warehouse' do
    code "MyString"
    name "MyString"
    warehouse_type_category
  end

  factory :warehouse_a, class: 'SalesModeling::Purchase::Warehouse' do
    name 'A'
    warehouse_type_category
  end
end
