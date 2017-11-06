FactoryGirl.define do
  factory :year_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Type3::ValueObject::Year.new('', '').category_class_code
    name '年度'
  end
  factory :season_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Type3::ValueObject::Season.new('', '').category_class_code
    name 'シーズン'
  end
  factory :product_type_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Type3::ValueObject::ProductType.new('', '').category_class_code
    name '商品区分'
  end
  factory :brand_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Type3::ValueObject::Brand.new('', '').category_class_code
    name 'ブランド'
  end
  factory :color_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Type3::ValueObject::Color.new('', '').category_class_code
    name '色'
  end
  factory :size_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code SalesModeling::Type3::ValueObject::Size.new('', '').category_class_code
    name 'サイズ'
  end
end
