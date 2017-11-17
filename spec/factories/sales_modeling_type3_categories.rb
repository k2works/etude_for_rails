FactoryGirl.define do
  factory :year_category, class: 'SalesModeling::Type3::Category' do
    code  SalesModeling::Category::Year.new('1','').code
    name '2017'
    association :sales_modeling_type3_category_class, factory: :year_category_class
  end
  factory :season_category, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Category::Season.new('2','').code
    name '春夏物'
    association :sales_modeling_type3_category_class, factory: :season_category_class
    association :parent_category, factory: :year_category
  end
  factory :product_type_category_sub1, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type::ProductType.new('3','').code
    name 'カジュアル'
    association :sales_modeling_type3_category_class, factory: :product_type_category_class
  end
  factory :product_type_category_sub2, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type::ProductType.new('4','').code
    name 'Tシャツ'
    association :sales_modeling_type3_category_class, factory: :product_type_category_class
    association :parent_category, factory: :product_type_category_sub1
  end
  factory :brand_category_sub1, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Category::Brand.new('5','').code
    name 'X'
    association :sales_modeling_type3_category_class, factory: :brand_category_class
  end
  factory :brand_category_sub2, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Category::Brand.new('6','').code
    name 'X1'
    association :sales_modeling_type3_category_class, factory: :brand_category_class
    association :parent_category, factory: :brand_category_sub1
  end
  factory :color_category, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Category::Color.new('7','').code
    name 'ネイビー'
    association :sales_modeling_type3_category_class, factory: :color_category_class
  end
  factory :size_category, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Category::Size.new('8','').code
    name 'L'
    association :sales_modeling_type3_category_class, factory: :size_category_class
  end
  factory :customer_type_category, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type::CustomerType.new('9','一般').code
    name '一般'
    association :sales_modeling_type3_category_class, factory: :sales_type_category_class
  end
  factory :sales_estimate_type_category, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type::CustomerType.new('10','見積').code
    name '見積'
    symbol SalesModeling::Type::SalesEstimateType::SYMBOL
    association :sales_modeling_type3_category_class, factory: :sales_type_category_class
  end
  factory :sales_order_type_category, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type::CustomerType.new('11','売上').code
    name '見積'
    symbol SalesModeling::Type::SalesOrderType::SYMBOL
    association :sales_modeling_type3_category_class, factory: :sales_type_category_class
  end
  factory :supplier_type_category, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type::CustomerType.new('12','卸売').code
    name '卸売'
    symbol SalesModeling::Type::SupplierType::SYMBOL
    association :sales_modeling_type3_category_class, factory: :supplier_type_category_class
  end
end
