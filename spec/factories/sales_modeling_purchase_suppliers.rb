FactoryGirl.define do
  factory :sales_modeling_purchase_supplier, class: 'SalesModeling::Purchase::Supplier' do
    code "MyString"
    name "MyString"
    prefecture "MyString"
    city "MyString"
    house_number "MyString"
    telephone_number "MyString"
    supplier_type_category
  end

  factory :supplier_a, class: 'SalesModeling::Purchase::Supplier' do
    supplier_type_category
  end
end
