  
  
SalesModeling
---
# アパレル業務における商品設計
  
## アパレルでの商品管理
  
## 仕様
  
+ 商品管理のために、さまざまな分類で商品を定義する
+ 商品は「品番」で管理
+ 同じ商品でも「サイズ」と「カラー」はSKU（ストックキーピングユニット）として管理することが多い
### 品番で管理
  
|年度   |       | シーズン |    |
|:----:|:----: |:----:   |:----:|
|     | 2017 |         |春夏物||
|     |      |         |秋冬物|
|     | 2018 |         |春夏物||
|     |      |         |秋冬物|
  
|商品区分  |    |    |
|:----:   |:----:|:----:|
|         | カジュアル  |Tシャツ|
|         |           |ジャケット|
|         |           |...|
  
  
|ブランド  |    |    |
|:----:   |:----:|:----:|
|         | X  |X1|
|         |    |X2|
|         |    |X3|
|         | Y  |Y1|
|         |    |Y2|
  
### SKUで管理
  
|       |L          |M            |S            |
|:----: |:----:     |:----:       |:----:|
|ネイビー|品番:P0001  | 品番:P0001  | 品番:P0001   |
|ピンク  |品番:P0002  | 品番:P0002  | 品番:P0002   |
|ホワイト|品番:P0003  | 品番:P0003  | 品番:P0003   |
  
## 分析モデル
  

![](assets/0f28a17f695955efdbee3d6cf0374be10.png?0.2235518344817249)  
## 設計モデル
  

![](assets/0f28a17f695955efdbee3d6cf0374be11.png?0.4732475087990933)  
## ERモデル
  

![](assets/0f28a17f695955efdbee3d6cf0374be12.png?0.8456692005310134)  
`SKU`
```rb
# == Schema Information
#
# Table name: sales_modeling_type3_skus # ストックキーピングユニット
#
#  id                              :integer          not null, primary key
#  code                            :string(255)                            # SKUコード
#  unit_purchase_price_amount      :decimal(10, )                          # 仕入単価
#  unit_purchase_price_currency    :string(255)                            # 仕入単価通貨
#  unit_sales_price_amount         :decimal(10, )                          # 販売単価
#  unit_sales_price_currency       :string(255)                            # 販売単価通貨
#  sales_modeling_type3_product_id :integer                                # 商品
#  size_category_id                :integer                                # サイズ
#  color_category_id               :integer                                # 色
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#
# Indexes
#
#  index_sales_modeling_type3_on_product_id  (sales_modeling_type3_product_id)
#  index_type3_color_category_id             (color_category_id)
#  index_type3_size_category_id              (size_category_id)
#
# Foreign Keys
#
#  fk_rails_9ce8082daa  (sales_modeling_type3_product_id => sales_modeling_type3_products.id)
#
  
class SalesModeling::Type3::Sku < ApplicationRecord
  belongs_to :sales_modeling_type3_product, :class_name => 'SalesModeling::Type3::Product', dependent: :destroy
  belongs_to :size_category, :class_name => 'SalesModeling::Type3::Category'
  belongs_to :color_category, :class_name => 'SalesModeling::Type3::Category'
  
  def unit_purchase_price
    @unit_purchase_price ||= SalesModeling::Type3::ValueObject::Money.new(self.unit_purchase_price_amount)
  end
  
  def unit_purchase_price=(money)
    self.unit_purchase_price_amount = money.amount
    self.unit_purchase_price_currency = money.currency
  end
  
  def unit_sales_price
    @unit_sales_price ||= SalesModeling::Type3::ValueObject::Money.new(self.unit_sales_price_amount)
  end
  
  def unit_sales_price=(money)
    self.unit_sales_price_amount = money.amount
    self.unit_sales_price_currency = money.currency
  end
end
  
```  
`Product`
```rb
# == Schema Information
#
# Table name: sales_modeling_type3_products # 商品
#
#  id                       :integer          not null, primary key
#  code                     :string(255)                            # 商品コード
#  name                     :string(255)                            # 商品名
#  product_type_category_id :integer                                # 製品区分
#  brand_category_id        :integer                                # ブランド
#  season_category_id       :integer                                # シーズン
#  year_category_id         :integer                                # 年度
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_type3_brand_category_id         (brand_category_id)
#  index_type3_product_type_category_id  (product_type_category_id)
#  index_type3_season_category_id        (season_category_id)
#  index_type3_year_category_id          (year_category_id)
#
  
class SalesModeling::Type3::Product < ApplicationRecord
  belongs_to :product_type_category, :class_name => 'SalesModeling::Type3::Category'
  belongs_to :brand_category, :class_name => 'SalesModeling::Type3::Category'
  belongs_to :season_category, :class_name => 'SalesModeling::Type3::Category'
  belongs_to :year_category, :class_name => 'SalesModeling::Type3::Category', optional: true
  has_many :skus, :class_name => 'SalesModeling::Type3::Sku', :foreign_key => 'sales_modeling_type3_product_id'
  
  def product_code
    @product_code ||= SalesModeling::Type3::ValueObject::ProductCode.new(self.code)
  end
  
  def product_code=(product_code)
    self.code = SalesModeling::Type3::ValueObject::ProductCode.new(product_code.code).code
  end
  
  def year
    @year ||= SalesModeling::Type3::ValueObject::Year.new(self.year_category.code, self.year_category.name) unless self.year_category.nil?
  end
  
  def season
    @season ||= SalesModeling::Type3::ValueObject::Season.new(self.season_category.code, self.season_category.name)
  end
  
  def season=(season)
    season = SalesModeling::Type3::ValueObject::Season.new(season.code, season.name)
    season = SalesModeling::Type3::Category.where(
        code:season.code,
        name:season.name
    ).first_or_create
    season.save!
  
    self.season_category = season
  
    unless season.parent_category.nil?
      year = season.parent_category
      year = SalesModeling::Type3::ValueObject::Season.new(year.code, year.name)
      year = SalesModeling::Type3::Category.where(
          code:year.code,
          name:year.name
      ).first_or_create
      year.save!
  
      self.year_category = year
    end
  end
  
  def type
    @type ||= SalesModeling::Type3::ValueObject::ProductType.new(self.product_type_category.code, self.product_type_category.name)
  end
  
  def type=(type)
    type = SalesModeling::Type3::ValueObject::ProductType.new(type.code, type.name)
    type = SalesModeling::Type3::Category.where(
        code:type.code,
        name:type.name
    ).first_or_create
    type.save!
  
    self.product_type_category = type
  end
  
  def brand
    @brand ||= SalesModeling::Type3::ValueObject::Brand.new(self.brand_category.code, self.brand_category.name)
  end
  
  def brand=(brand)
    brand = SalesModeling::Type3::Category.where(
        code:brand.code,
        name:brand.name
    ).first_or_create
    brand.save!
  
    self.brand_category = brand
  end
end
  
```  
`Category`
```rb
# == Schema Information
#
# Table name: sales_modeling_type3_categories # 分類
#
#  id                                     :integer          not null, primary key
#  code                                   :string(255)                            # コード
#  name                                   :string(255)                            # 分類名
#  sales_modeling_type3_category_class_id :integer
#  parent_category_id                     :integer                                # 親カテゴリ
#  created_at                             :datetime         not null
#  updated_at                             :datetime         not null
#
# Indexes
#
#  index_sales_modeling_type3_categories_on_parent_category_id  (parent_category_id)
#  index_sales_modeling_type3_on_category_class_id              (sales_modeling_type3_category_class_id)
#
# Foreign Keys
#
#  fk_rails_0220975bcb  (sales_modeling_type3_category_class_id => sales_modeling_type3_category_classes.id)
#
  
class SalesModeling::Type3::Category < ApplicationRecord
  belongs_to :sales_modeling_type3_category_class, :class_name => 'SalesModeling::Type3::CategoryClass', optional: true
  belongs_to :parent_category, :class_name => 'SalesModeling::Type3::Category', optional: true
  has_many :categories, :class_name => 'SalesModeling::Type3::Category', :foreign_key => 'parent_category_id'
  has_many :sku_sizes, :class_name => 'SalesModeling::Type3::Sku', :foreign_key => 'size_category_id'
  has_many :sku_colors, :class_name => 'SalesModeling::Type3::Sku', :foreign_key => 'color_category_id'
  has_many :product_type_categories, :class_name => 'SalesModeling::Type3::Product', :foreign_key => 'product_type_category_id'
  has_many :brand_categories, :class_name => 'SalesModeling::Type3::Product', :foreign_key => 'brand_category_id'
  has_many :season_categories, :class_name => 'SalesModeling::Type3::Product', :foreign_key => 'season_category_id'
  has_many :year_categories, :class_name => 'SalesModeling::Type3::Product', :foreign_key => 'year_category_id'
end
  
```  
`CategoryClass`
```rb
# == Schema Information
#
# Table name: sales_modeling_type3_category_classes # 分類種別
#
#  id         :integer          not null, primary key
#  code       :string(255)                            # コード
#  name       :string(255)                            # 分類種別名
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
  
class SalesModeling::Type3::CategoryClass < ApplicationRecord
  has_many :categories, :class_name => 'SalesModeling::Type3::Category', :foreign_key => 'sales_modeling_type3_category_class_id'
end
  
```  
`ProductCode`
```rb
class SalesModeling::Type3::ValueObject::ProductCode
  attr_reader :code
  
  def initialize(code)
    if code.slice(0) == 'p'
      @code = code.rjust(4,'0')
    else
      @code = "p#{code.rjust(4,'0')}"
    end
    valid?
  end
  
  def hash
    self.hash
  end
  
  def valid?
    raise "Not prodcut code format" unless @code.length == 5
    raise "Not prodcut code format" unless @code.slice(0) == 'p'
  end
end
```  
`Money`
```rb
class SalesModeling::Type3::ValueObject::Money
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
  
    SalesModeling::Type3::ValueObject::Money.new(amount + other.amount, currency)
  end
  
  def -(other)
    raise "Currency is different" unless currency == other.currency
    raise "Other money is bigger than self" if amount < other.amount
  
    SalesModeling::Type3::ValueObject::Money.new(amount - other.amount, currency)
  end
end
```  
`Year`
```rb
class SalesModeling::Type3::ValueObject::Year
  attr_reader :code, :name
  
  def initialize(code, name)
    @code = code.rjust(5,'0')
    @name = name
    valid?
  end
  
  def hash
    self.hash
  end
  
  def valid?
    raise "Invalid code format" unless @code.length == 5
  end
end
```  
`Season`
```rb
class SalesModeling::Type3::ValueObject::Season
  attr_reader :code, :name
  
  def initialize(code, name)
    @code = code.rjust(5,'0')
    @name = name
    valid?
  end
  
  def hash
    self.hash
  end
  
  def valid?
    raise "Invarid code format" unless @code.length == 5
  end
end
```  
`ProductType`
```rb
class SalesModeling::Type3::ValueObject::ProductType
  attr_reader :code, :name
  
  def initialize(code, name)
    @code = code.rjust(2,'0')
    @name = name
    valid?
  end
  
  def hash
    self.hash
  end
  
  def valid?
    raise "Bad code format" unless code.length == 2
  end
end
```  
`Brand`
```rb
class SalesModeling::Type3::ValueObject::Brand
  attr_reader :code, :name
  
  def initialize(code, name)
    @code = code.rjust(5,'0')
    @name = name
    valid?
  end
  
  def hash
    self.hash
  end
  
  def valid?
    raise "Invalid code format" unless code.length == 5
  end
end
```  
  