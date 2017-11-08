FactoryGirl.define do
  factory :sales_modeling_sales_estimate, class: 'SalesModeling::Sales::Estimate' do
    sales_estimate nil
    sales_order nil
  end
end
