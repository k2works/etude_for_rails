FactoryGirl.define do
  factory :year_category, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type3::ValueObject::Year.new('1','').code
    name '2017'
    association :sales_modeling_type3_category_class, factory: :year_category_class
  end
  factory :season_category, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type3::ValueObject::Season.new('2','').code
    name '春夏物'
    association :sales_modeling_type3_category_class, factory: :season_category_class
    association :parent_category, factory: :year_category
  end
  factory :product_type_category_sub1, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type3::ValueObject::ProductType.new('3','').code
    name 'カジュアル'
    association :sales_modeling_type3_category_class, factory: :product_type_category_class
  end
  factory :product_type_category_sub2, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type3::ValueObject::ProductType.new('4','').code
    name 'Tシャツ'
    association :sales_modeling_type3_category_class, factory: :product_type_category_class
    association :parent_category, factory: :product_type_category_sub1
  end
  factory :brand_category_sub1, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type3::ValueObject::Brand.new('5','').code
    name 'X'
    association :sales_modeling_type3_category_class, factory: :brand_category_class
  end
  factory :brand_category_sub2, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type3::ValueObject::Brand.new('6','').code
    name 'X1'
    association :sales_modeling_type3_category_class, factory: :brand_category_class
    association :parent_category, factory: :brand_category_sub1
  end
  factory :color_category, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type3::ValueObject::Color.new('7','').code
    name 'ネイビー'
    association :sales_modeling_type3_category_class, factory: :color_category_class
  end
  factory :size_category, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type3::ValueObject::Size.new('8','').code
    name 'L'
    association :sales_modeling_type3_category_class, factory: :size_category_class
  end
end
