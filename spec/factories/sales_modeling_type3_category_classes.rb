FactoryGirl.define do
  factory :year_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code '1'
    name '年度'
  end
  factory :season_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code '2'
    name 'シーズン'
  end
  factory :product_type_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code '3'
    name '商品区分'
  end
  factory :brand_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code '4'
    name 'ブランド'
  end
  factory :color_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code '5'
    name '色'
  end
  factory :size_category_class, class: 'SalesModeling::Type3::CategoryClass' do
    code '6'
    name 'サイズ'
  end
end
