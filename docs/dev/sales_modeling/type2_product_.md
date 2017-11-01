  
  
SalesModeling
---
# 分類を汎化した商品モデル
  
## 分析モデル
  

![](assets/18ea6da402e4324333324e00d3b39f9d0.png?0.5839159950701984)  
## 設計モデル
  

![](assets/18ea6da402e4324333324e00d3b39f9d1.png?0.3822151868581143)  
## ERモデル
  

![](assets/18ea6da402e4324333324e00d3b39f9d2.png?0.5856196700603202)  
`Product`
```rb
# == Schema Information
#
# Table name: sales_modeling_type2_products # 商品
#
#  id                           :integer          not null, primary key
#  code                         :string(255)                            # 商品コード
#  name                         :string(255)                            # 商品名
#  size_category_id             :integer                                # サイズ
#  color_category_id            :integer                                # 色
#  product_type_category_id     :integer                                # 製品区分
#  unit_purchase_price_amount   :decimal(10, )                          # 仕入単価
#  unit_purchase_price_currency :string(255)                            # 仕入単価通貨
#  unit_sales_price_amount      :decimal(10, )                          # 販売単価
#  unit_sales_price_currency    :string(255)                            # 販売単価通貨
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
# Indexes
#
#  index_color_category_id         (color_category_id)
#  index_product_type_category_id  (product_type_category_id)
#  index_size_category_id          (size_category_id)
#
  
class SalesModeling::Type2::Product < ApplicationRecord
  belongs_to :size_category, :class_name => 'SalesModeling::Type2::Category'
  belongs_to :color_category, :class_name => 'SalesModeling::Type2::Category'
  belongs_to :product_type_category, :class_name => 'SalesModeling::Type2::Category'
  
  def product_code
    @product_code ||= SalesModeling::Type2::ProductCode.new(self.code)
  end
  
  def product_code=(product_code)
    self.code = product_code.code
  end
  
  def unit_purchase_price
    @unit_purchase_price ||= SalesModeling::Type2::Money.new(self.unit_purchase_price_amount)
  end
  
  def unit_purchase_price=(money)
    self.unit_purchase_price_amount = money.amount
    self.unit_purchase_price_currency = money.currency
  end
  
  def unit_sales_price
    @unit_sales_price ||= SalesModeling::Type2::Money.new(self.unit_sales_price_amount)
  end
  
  def unit_sales_price=(money)
    self.unit_sales_price_amount = money.amount
    self.unit_sales_price_currency = money.currency
  end
end
  
```  
`Category`
```rb
# == Schema Information
#
# Table name: sales_modeling_type2_categories # 分類
#
#  id                                     :integer          not null, primary key
#  code                                   :string(255)                            # コード
#  name                                   :string(255)                            # 分類名
#  sales_modeling_type2_category_class_id :integer
#  parent_category_id                     :integer                                # 親カテゴリ
#  created_at                             :datetime         not null
#  updated_at                             :datetime         not null
#
# Indexes
#
#  index_sales_modeling_type2_categories_on_parent_category_id  (parent_category_id)
#  index_sales_modeling_type2_on_category_class_id              (sales_modeling_type2_category_class_id)
#
# Foreign Keys
#
#  fk_rails_ab95b4e6fd  (sales_modeling_type2_category_class_id => sales_modeling_type2_category_classes.id)
#
  
class SalesModeling::Type2::Category < ApplicationRecord
  belongs_to :sales_modeling_type2_category_class, :class_name => 'SalesModeling::Type2::CategoryClass'
  belongs_to :parent_category, :class_name => 'SalesModeling::Type2::Category', optional: true
  has_many :sales_modeling_type2_categories, :class_name => 'SalesModeling::Type2::Category', :foreign_key => 'parent_category_id'
  has_many :sales_modeling_type2_product_sizes, :class_name => 'SalesModeling::Type2::Product', :foreign_key => 'size_id'
  has_many :sales_modeling_type2_product_colors, :class_name => 'SalesModeling::Type2::Product', :foreign_key => 'color_id'
  has_many :sales_modeling_type2_product_product_categories, :class_name => 'SalesModeling::Type2::Product', :foreign_key => 'product_category_id'
end
  
```  
`CategoryClass`
```rb
# == Schema Information
#
# Table name: sales_modeling_type2_category_classes # 分類種別
#
#  id         :integer          not null, primary key
#  code       :string(255)                            # コード
#  name       :string(255)                            # 分類種別名
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
  
class SalesModeling::Type2::CategoryClass < ApplicationRecord
  has_many :sales_modeling_type2_categories, :class_name => 'SalesModeling::Type2::Category', :foreign_key => 'sales_modeling_type2_category_class_id'
end
  
```  
`ProductCode`
```rb
class SalesModeling::Type2::ProductCode
  attr_reader :code
  
  def initialize(code)
    @code = code
    valid?
  end
  
  def hash
    self.hash
  end
  
  def valid?
    raise "Not prodcut code format" unless @code.length == 10
  end
end
```  
`Money`
```rb
class SalesModeling::Type2::Money
  attr_reader :amount, :currency
  
  def initialize(amount, currency = "JPY")
    @amount = amount
    @currency = currency
  end
  
  def ==(other)
    amount == other.amount && currency == other.currency
  end
  
  def +(other)
    raise "Currency is different" unless currency == other.currency
  
    SalesModeling::Type2::Money.new(amount + other.amount, currency)
  end
  
  def -(other)
    raise "Currency is different" unless currency == other.currency
    raise "Other money is bigger than self" if amount < other.amount
  
    SalesModeling::Type2::Money.new(amount - other.amount, currency)
  end
end
```  
  