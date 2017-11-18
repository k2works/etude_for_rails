FactoryGirl.define do
  factory :year_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Category::Year.new('', '').category_class_code
    name '年度'
  end
  factory :season_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Category::Season.new('', '').category_class_code
    name 'シーズン'
  end
  factory :product_type_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Type::ProductType.new('', '').category_class_code
    name '商品区分'
  end
  factory :brand_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Category::Brand.new('', '').category_class_code
    name 'ブランド'
  end
  factory :color_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Category::Color.new('', '').category_class_code
    name '色'
  end
  factory :size_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Category::Size.new('', '').category_class_code
    name 'サイズ'
  end
  factory :customer_type_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Type::CustomerType.new('', '').category_class_code
    name '顧客区分'
  end
  factory :sales_type_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Type::ProductType.new('', '').category_class_code
    name '販売区分'
  end
  factory :supplier_type_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Type::SupplierType.new('', '').category_class_code
    name '仕入先区分'
  end
  factory :order_type_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Type::OrderType.new('', '').category_class_code
    name '発注区分'
  end
  factory :warehouse_type_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Type::WarehouseType.new('', '').category_class_code
    name '倉庫区分'
  end
end
