FactoryGirl.define do
  factory :sku_1, class: 'SalesModeling::Type3::Sku' do
    association :sales_modeling_type3_product, factory: :product_1
    size_category
    color_category
  end
end
