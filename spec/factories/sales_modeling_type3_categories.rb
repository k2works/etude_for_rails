FactoryGirl.define do
  factory :year_category, class: 'SalesModeling::Type3::Category' do
    code '1'
    name '2017'
    association :sales_modeling_type3_category_class, factory: :year_category_class
  end
  factory :season_category, class: 'SalesModeling::Type3::Category' do
    code '2'
    name '春夏物'
    association :sales_modeling_type3_category_class, factory: :season_category_class
    association :parent_category, factory: :year_category
  end
  factory :product_type_category_sub1, class: 'SalesModeling::Type3::Category' do
    code '3'
    name 'カジュアル'
    association :sales_modeling_type3_category_class, factory: :product_type_category_class
  end
  factory :product_type_category_sub2, class: 'SalesModeling::Type3::Category' do
    code '4'
    name 'Tシャツ'
    association :sales_modeling_type3_category_class, factory: :product_type_category_class
    association :parent_category, factory: :product_type_category_sub1
  end
  factory :brand_category_sub1, class: 'SalesModeling::Type3::Category' do
    code '5'
    name 'X'
    association :sales_modeling_type3_category_class, factory: :brand_category_class
  end
  factory :brand_category_sub2, class: 'SalesModeling::Type3::Category' do
    code '6'
    name 'X1'
    association :sales_modeling_type3_category_class, factory: :brand_category_class
    association :parent_category, factory: :brand_category_sub1
  end
  factory :color_category, class: 'SalesModeling::Type3::Category' do
    code '7'
    name 'ネイビー'
    association :sales_modeling_type3_category_class, factory: :color_category_class
  end
  factory :size_category, class: 'SalesModeling::Type3::Category' do
    code '8'
    name 'L'
    association :sales_modeling_type3_category_class, factory: :size_category_class
  end
end
