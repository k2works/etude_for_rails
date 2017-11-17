FactoryGirl.define do
  factory :product_1, class: 'SalesModeling::Type3::Product' do
    code  SalesModeling::Code::ProductCode.new('1').code
    name '製品A'
    association :product_type_category, factory: :product_type_category_sub2
    association :brand_category, factory: :brand_category_sub2
    year_category
    season_category
  end

  factory :product_2, class: 'SalesModeling::Type3::Product' do
    code  SalesModeling::Code::ProductCode.new('1').code
    name '製品B'
    association :product_type_category, factory: :product_type_category_sub2
    association :brand_category, factory: :brand_category_sub2
    year_category
    season_category
  end

  factory :product_3, class: 'SalesModeling::Type3::Product' do
    code  SalesModeling::Code::ProductCode.new('1').code
    name '製品C'
    association :product_type_category, factory: :product_type_category_sub2
    association :brand_category, factory: :brand_category_sub2
    year_category
    season_category
  end
end
