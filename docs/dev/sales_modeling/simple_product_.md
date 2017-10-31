  
  
SalesModeling
---
# シンプルな商品モデル
  
## 分析モデル
  

![](../../../assets/29814634b37d876b69ac99006d75fb210.png?0.4904732783148207)  
## 設計モデル
  

![](../../../assets/29814634b37d876b69ac99006d75fb211.png?0.6791891320274084)  
## ERモデル
  

![](../../../assets/29814634b37d876b69ac99006d75fb212.png?0.2391995963791127)  
`Product`
```rb
# == Schema Information
#
# Table name: sales_modeling_type1_products # 商品
#
#  id                                       :integer          not null, primary key
#  code                                     :string(255)                            # 商品コード
#  name                                     :string(255)                            # 商品名
#  sales_modeling_type1_size_id             :integer
#  sales_modeling_type1_color_id            :integer
#  sales_modeling_type1_product_category_id :integer
#  unit_purchase_price_amount               :decimal(10, )                          # 仕入単価
#  unit_purchase_price_currency             :string(255)                            # 仕入単価通貨
#  unit_sales_price_amount                  :decimal(10, )                          # 販売単価
#  unit_sales_price_currency                :string(255)                            # 販売単価通貨
#  created_at                               :datetime         not null
#  updated_at                               :datetime         not null
#
# Indexes
#
#  index_sales_modeling_type1_on_color_id             (sales_modeling_type1_color_id)
#  index_sales_modeling_type1_on_product_category_id  (sales_modeling_type1_product_category_id)
#  index_sales_modeling_type1_on_size_id              (sales_modeling_type1_size_id)
#
# Foreign Keys
#
#  fk_rails_a430deaab8  (sales_modeling_type1_size_id => sales_modeling_type1_sizes.id)
#  fk_rails_c635ddefc9  (sales_modeling_type1_color_id => sales_modeling_type1_colors.id)
#  fk_rails_c9d507139e  (sales_modeling_type1_product_category_id => sales_modeling_type1_product_categories.id)
#
  
class SalesModeling::Type1::Product < ApplicationRecord
  belongs_to :sales_modeling_type1_color, :class_name => 'SalesModeling::Type1::Color'
  belongs_to :sales_modeling_type1_product_category, :class_name => 'SalesModeling::Type1::ProductCategory'
  belongs_to :sales_modeling_type1_size, :class_name => 'SalesModeling::Type1::Size'
  
  def jan
    @jan ||= SalesModeling::JANCode.new(self.code)
  end
  
  def jan=(jan)
    self.code = jan.code
    @jan = jan
  end
  
  def size=(size)
    self.sales_modeling_type1_size = size
  end
  
  def size
    self.sales_modeling_type1_size
  end
  
  def color=(color)
    self.sales_modeling_type1_color = color
  end
  
  def color
    self.sales_modeling_type1_color
  end
  
  def product_category=(product_category)
    self.sales_modeling_type1_product_category = product_category
  end
  
  def product_category
    self.sales_modeling_type1_product_category
  end
  
  def unit_purchase_price
    @unit_purchase_price ||= SalesModeling::Money.new(self.unit_purchase_price_amount)
  end
  
  def unit_purchase_price=(money)
    self.unit_purchase_price_amount = money.amount
    self.unit_purchase_price_currency = money.currency
  end
  
  def unit_sales_price
    @unit_sales_price ||= SalesModeling::Money.new(self.unit_sales_price_amount)
  end
  
  def unit_sales_price=(money)
    self.unit_sales_price_amount = money.amount
    self.unit_sales_price_currency = money.currency
  end
end
  
```  
`Size`
```rb
# == Schema Information
#
# Table name: sales_modeling_type1_sizes
#
#  id         :integer          not null, primary key
#  code       :string(255)                            # コード
#  name       :string(255)                            # 名前
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
  
class SalesModeling::Type1::Size < ApplicationRecord
  has_many :sales_modeling_type1_products, :class_name => 'SalesModeling::Type1::Product'
end
  
```  
`Color`
```rb
# == Schema Information
#
# Table name: sales_modeling_type1_colors # カラー
#
#  id         :integer          not null, primary key
#  code       :string(255)                            # コード
#  name       :string(255)                            # 名前
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
  
class SalesModeling::Type1::Color < ApplicationRecord
  has_many :sales_modeling_type1_products, :class_name => 'SalesModeling::Type1::Product'
end
  
```  
`ProductCategory`
```rb
# == Schema Information
#
# Table name: sales_modeling_type1_product_categories # 商品区分
#
#  id         :integer          not null, primary key
#  code       :string(255)                            # コード
#  name       :string(255)                            # 名前
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
  
class SalesModeling::Type1::ProductCategory < ApplicationRecord
  has_many :sales_modeling_type1_products, :class_name => 'SalesModeling::Type1::Product'
end
  
```  
`JANCode`
```rb
class SalesModeling::Type1::JANCode
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
    raise "Not JAN code format" unless @code.length == 13
  end
end
```  
`Money`
```rb
class SalesModeling::Type1::Money
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
  
    SalesModeling::Type1::Money.new(amount + other.amount, currency)
  end
  
  def -(other)
    raise "Currency is different" unless currency == other.currency
    raise "Other money is bigger than self" if amount < other.amount
  
    SalesModeling::Type1::Money.new(amount - other.amount, currency)
  end
end
```  
  