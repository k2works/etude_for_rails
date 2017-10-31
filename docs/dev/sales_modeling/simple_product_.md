  
  
SalesModeling
---
# シンプルな商品モデル
  
## 分析モデル
  

![](assets/29814634b37d876b69ac99006d75fb210.png?0.6829049201598165)  
## 設計モデル
  

![](assets/29814634b37d876b69ac99006d75fb211.png?0.13988046947345967)  
## ERモデル
  

![](assets/29814634b37d876b69ac99006d75fb212.png?0.15940943603052293)  
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
  
  def jan
    @jan ||= SalesModeling::JANCode.new(self.code)
  end
  
  def jan=(jan)
    self.code = jan.code
    @jan = jan
  end
  
  def size=(size)
    self.sales_modeling_size = size
  end
  
  def size
    self.sales_modeling_size
  end
  
  def color=(color)
    self.sales_modeling_color = color
  end
  
  def color
    self.sales_modeling_color
  end
  
  def product_category=(product_category)
    self.sales_modeling_product_category = product_category
  end
  
  def product_category
    self.sales_modeling_product_category
  end
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
`JANCode`
```rb
class SalesModeling::JANCode
  attr_reader :code,:country_code,:maker_code,:product_item_code,:check_digit
  
  def initialize(code)
    @code = code
    valid?
    @country_code = @code.slice(0,2)
    @maker_code = @code.slice(3,7)
    @product_item_code = @code.slice(9,3)
    @check_digit = @code.slice(12,1)
  end
  
  def hash
    self.hash
  end
  
  def valid?
    raise unless @code.length == 13
  end
end
```  
  