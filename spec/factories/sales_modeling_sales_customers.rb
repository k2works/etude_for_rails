FactoryGirl.define do
  factory :sales_modeling_sales_customer, class: 'SalesModeling::Sales::Customer' do
    code "MyStr"
    name "MyString"
    prefecture "MyString"
    city "MyString"
    house_number "MyString"
    telephone_number "MyString"
    customer_type_category nil
  end

  factory :normal_customer, class: 'SalesModeling::Sales::Customer' do
    customer_type_category
  end
end
