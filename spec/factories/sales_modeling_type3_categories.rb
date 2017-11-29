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
  factory :order_type_category, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type::OrderType.new('13','発注').code
    name '発注'
    symbol SalesModeling::Type::OrderType::SYMBOL
    association :sales_modeling_type3_category_class, factory: :order_type_category_class
  end
  factory :simple_order_type_category, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type::SimpleOrderType.new('14','簡易').code
    name '簡易'
    symbol SalesModeling::Type::SimpleOrderType::SYMBOL
    association :sales_modeling_type3_category_class, factory: :order_type_category_class
  end
  factory :fix_size_order_type_category, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type::FixSizeOrderType.new('15','定量').code
    name '簡易'
    symbol SalesModeling::Type::FixSizeOrderType::SYMBOL
    association :sales_modeling_type3_category_class, factory: :order_type_category_class
  end
  factory :regular_order_type_category, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type::RegularOrderType.new('16','定期').code
    name '定期'
    symbol SalesModeling::Type::RegularOrderType::SYMBOL
    association :sales_modeling_type3_category_class, factory: :order_type_category_class
  end
  factory :warehouse_type_category, class: 'SalesModeling::Type3::Category' do
    code SalesModeling::Type::WarehouseType.new('17','倉庫').code
    name '倉庫'
    symbol SalesModeling::Type::WarehouseType::SYMBOL
    association :sales_modeling_type3_category_class, factory: :warehouse_type_category_class
  end
end
