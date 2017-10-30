  
  
SalesModeling
---
## 商品モデルの設計
  
### シンプルな商品モデル
  
#### 分析モデル
  

![](../../../assets/07369ce125477171d3f4392d84e914cc0.png?0.2914215115639063)  
#### 設計モデル
  

![](../../../assets/07369ce125477171d3f4392d84e914cc1.png?0.33799897217388963)  
#### ERモデル
  

![](../../../assets/07369ce125477171d3f4392d84e914cc2.png?0.5537414511979135)  
`Product`
```rb
# == Schema Information
#
# Table name: sales_modeling_products # 商品
#
#  id                                 :integer          not null, primary key
#  code                               :string(255)                            # 商品コード
#  name                               :string(255)                            # 商品名
#  sales_modeling_size_id             :integer
#  sales_modeling_color_id            :integer
#  sales_modeling_product_category_id :integer
#  unit_purchase_price                :decimal(10, )                          # 仕入単価
#  unit_sales_price                   :decimal(10, )                          # 販売単価
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#
# Indexes
#
#  index_sales_modeling_on_color_id             (sales_modeling_color_id)
#  index_sales_modeling_on_product_category_id  (sales_modeling_product_category_id)
#  index_sales_modeling_on_size_id              (sales_modeling_size_id)
#
# Foreign Keys
#
#  fk_rails_3793dc5944  (sales_modeling_product_category_id => sales_modeling_product_categories.id)
#  fk_rails_b57b123249  (sales_modeling_color_id => sales_modeling_colors.id)
#  fk_rails_db80fcf3c4  (sales_modeling_size_id => sales_modeling_sizes.id)
#
  
class SalesModeling::Product < ApplicationRecord
  belongs_to :sales_modeling_color, :class_name => 'SalesModeling::Color'
  belongs_to :sales_modeling_product_category, :class_name => 'SalesModeling::ProductCategory'
  belongs_to :sales_modeling_size, :class_name => 'SalesModeling::Size'
end
  
```  
`Size`
```rb
# == Schema Information
#
# Table name: sales_modeling_sizes # サイズ
#
#  id         :integer          not null, primary key
#  code       :string(255)                            # コード
#  name       :string(255)                            # 名前
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
  
class SalesModeling::Size < ApplicationRecord
  has_many :sales_modeling_products, :class_name => 'SalesModeling::Product'
end
  
```  
`Color`
```rb
# == Schema Information
#
# Table name: sales_modeling_colors # カラー
#
#  id         :integer          not null, primary key
#  code       :string(255)                            # コード
#  name       :string(255)                            # 名前
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
  
class SalesModeling::Color < ApplicationRecord
  has_many :sales_modeling_products, :class_name => 'SalesModeling::Product'
end
  
```  
`ProductCategory`
```rb
# == Schema Information
#
# Table name: sales_modeling_product_categories # 商品区分
#
#  id         :integer          not null, primary key
#  code       :string(255)                            # コード
#  name       :string(255)                            # 名前
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
  
class SalesModeling::ProductCategory < ApplicationRecord
  has_many :sales_modeling_products, :class_name => 'SalesModeling::Product'
end
  
```  
  