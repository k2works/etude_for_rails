  
  
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
  

![](assets/0f28a17f695955efdbee3d6cf0374be10.png?0.4970695549671291)  
## 設計モデル
  

![](assets/0f28a17f695955efdbee3d6cf0374be11.png?0.7919955678325385)  
## ERモデル
  

![](assets/0f28a17f695955efdbee3d6cf0374be12.png?0.1209427775794274)  
`SKU`
```rb
# frozen_string_literal: true
  
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
  belongs_to :sales_modeling_type3_product, class_name: 'SalesModeling::Type3::Product'
  belongs_to :size_category, class_name: 'SalesModeling::Type3::Category'
  belongs_to :color_category, class_name: 'SalesModeling::Type3::Category'
  
  def sku_code
    @sku_code ||= SalesModeling::Type3::ValueObject::SkuCode.new(sales_modeling_type3_product.product_code.code, code)
  end
  
  def sku_code=(sku_code)
    self.code = sku_code.code
  end
  
  def unit_purchase_price
    @unit_purchase_price ||= SalesModeling::Type3::ValueObject::UnitPurchasePrice.new(unit_purchase_price_amount)
  end
  
  def unit_purchase_price=(money)
    self.unit_purchase_price_amount = money.amount
    self.unit_purchase_price_currency = money.currency
  end
  
  def unit_sales_price
    @unit_sales_price ||= SalesModeling::Type3::ValueObject::UnitSalesPrice.new(unit_sales_price_amount)
  end
  
  def unit_sales_price=(money)
    self.unit_sales_price_amount = money.amount
    self.unit_sales_price_currency = money.currency
  end
  
  def color
    @color ||= SalesModeling::Type3::ValueObject::Color.new(color_category.code, color_category.name)
  end
  
  def color=(color)
    color = SalesModeling::Type3::ValueObject::Color.new(color.code, color.name)
    self.color_category = SalesModeling::CategorysRepo.select_by_category(color)
  end
  
  def size
    @size ||= SalesModeling::Type3::ValueObject::Size.new(size_category.code, size_category.name)
  end
  
  def size=(size)
    size = SalesModeling::Type3::ValueObject::Size.new(size.code, size.name)
    self.size_category = SalesModeling::CategorysRepo.select_by_category(size)
  end
end
  
```  
`Product`
```rb
# frozen_string_literal: true
  
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
  belongs_to :product_type_category, class_name: 'SalesModeling::Type3::Category'
  belongs_to :brand_category, class_name: 'SalesModeling::Type3::Category'
  belongs_to :season_category, class_name: 'SalesModeling::Type3::Category'
  belongs_to :year_category, class_name: 'SalesModeling::Type3::Category', optional: true
  has_many :skus, class_name: 'SalesModeling::Type3::Sku', foreign_key: 'sales_modeling_type3_product_id', dependent: :destroy
  accepts_nested_attributes_for :skus, allow_destroy: true
  
  def product_code
    @product_code ||= SalesModeling::Type3::ValueObject::ProductCode.new(code)
  end
  
  def product_code=(product_code)
    self.code = SalesModeling::Type3::ValueObject::ProductCode.new(product_code.code).code
  end
  
  def year
    @year ||= SalesModeling::Type3::ValueObject::Year.new(year_category.code, year_category.name) unless year_category.nil?
  end
  
  def season
    @season ||= SalesModeling::Type3::ValueObject::Season.new(season_category.code, season_category.name)
  end
  
  def season=(season)
    season = SalesModeling::Type3::ValueObject::Season.new(season.code, season.name)
    self.season_category = SalesModeling::CategorysRepo.select_by_category(season)
  
    unless season_category.parent_category.nil?
      year = season_category.parent_category
      self.year_category = SalesModeling::CategorysRepo.select_by_category(year)
    end
  end
  
  def type
    @type ||= SalesModeling::Type3::ValueObject::ProductType.new(product_type_category.code, product_type_category.name)
  end
  
  def type=(type)
    type = SalesModeling::Type3::ValueObject::ProductType.new(type.code, type.name)
    self.product_type_category = SalesModeling::CategorysRepo.select_by_category(type)
  end
  
  def brand
    @brand ||= SalesModeling::Type3::ValueObject::Brand.new(brand_category.code, brand_category.name)
  end
  
  def brand=(brand)
    brand = SalesModeling::Type3::ValueObject::Brand.new(brand.code, brand.name)
    self.brand_category = SalesModeling::CategorysRepo.select_by_category(brand)
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
  include SalesModeling::Code
  attr_reader :code
  CODE_LENGTH = 4
  
  def initialize(code)
    if code.slice(0) == 'p'
      @code = code.rjust(CODE_LENGTH,'0')
    else
      @code = "p#{code.rjust(CODE_LENGTH,'0')}"
    end
    valid?
  end
  
  def hash
    self.hash
  end
  
  def valid?
    raise "Not prodcut code format" unless @code.length == CODE_LENGTH + 1
    raise "Not prodcut code format" unless @code.slice(0) == 'p'
  end
end
```  
`Year`
```rb
class SalesModeling::Type3::ValueObject::Year
  include SalesModeling::Code
end
```  
`Season`
```rb
class SalesModeling::Type3::ValueObject::Season
  include SalesModeling::Code
end
```  
`ProductType`
```rb
class SalesModeling::Type3::ValueObject::ProductType
  include SalesModeling::Type
end
```  
`Brand`
```rb
class SalesModeling::Type3::ValueObject::Brand
  include SalesModeling::Code
end
```  
`SkuCode`
```rb
class SalesModeling::Type3::ValueObject::SkuCode
  include SalesModeling::Code
  attr_reader :code
  CODE_LENGTH = 5
  
  def initialize(product_code,code)
    if code.length <= CODE_LENGTH
      @code = "#{product_code}-#{code.rjust(CODE_LENGTH,'0')}"
    else
      @code = code
    end
  
    valid?
  end
  
  def hash
    self.hash
  end
  
  def valid?
    raise "Not sku code format" unless @code.length == CODE_LENGTH + 6
    raise "Not sku code format" unless @code.slice(0) == 'p'
  end
end
```  
`Color`
```rb
class SalesModeling::Type3::ValueObject::Color
  include SalesModeling::Code
end
```  
`Size`
```rb
class SalesModeling::Type3::ValueObject::Size
  include SalesModeling::Code
end
```  
`UnitPurchasePrice`
```rb
class SalesModeling::Type3::ValueObject::UnitPurchasePrice
  include SalesModeling::Price
  
  def +(other)
    raise "Currency is different" unless currency == other.currency
  
    SalesModeling::Type3::ValueObject::UnitPurchasePrice.new(amount + other.amount, currency)
  end
  
  def -(other)
    raise "Currency is different" unless currency == other.currency
    raise "Other money is bigger than self" if amount < other.amount
  
    SalesModeling::Type3::ValueObject::UnitPurchasePrice.new(amount - other.amount, currency)
  end
end
```  
`UnitSalesPrice`
```rb
class SalesModeling::Type3::ValueObject::UnitSalesPrice
  include SalesModeling::Price
  
  def +(other)
    raise "Currency is different" unless currency == other.currency
  
    SalesModeling::Type3::ValueObject::UnitSalesPrice.new(amount + other.amount, currency)
  end
  
  def -(other)
    raise "Currency is different" unless currency == other.currency
    raise "Other money is bigger than self" if amount < other.amount
  
    SalesModeling::Type3::ValueObject::UnitSalesPrice.new(amount - other.amount, currency)
  end
end
```  
`Type`
```rb
module SalesModeling
  module Type
    extend ActiveSupport::Concern
    attr_reader :code, :name
    CODE_LENGTH = 2
  
    def initialize(code, name)
      @code = code.rjust(CODE_LENGTH,'0')
      @name = name
      valid?
    end
  
    def hash
      self.hash
    end
  
    def valid?
      raise "Invalid code format" unless code.length == CODE_LENGTH
    end
  end
end
```  
`Code`
```rb
module SalesModeling
  module Code
    extend ActiveSupport::Concern
    attr_reader :code, :name
    CODE_LENGTH = 5
  
    def initialize(code, name)
      @code = code.rjust(CODE_LENGTH,'0')
      @name = name
      valid?
    end
  
    def hash
      self.hash
    end
  
    def valid?
      raise "Invalid code format" unless code.length == CODE_LENGTH
    end
  end
end
  
```  
`Price`
```rb
module SalesModeling
  module Price
    extend ActiveSupport::Concern
  
    included do
      include Money
    end
  end
end
```  
`Money`
```rb
# frozen_string_literal: true
  
module SalesModeling
  module Money
    extend ActiveSupport::Concern
    attr_reader :amount, :currency
  
    def initialize(amount, currency = 'JPY')
      @amount = amount
      @currency = currency
    end
  
    def ==(other)
      amount == other.amount && currency == other.currency
    end
  
    def +(other)
    end
  
    def -(other)
    end
  end
end
  
```  
  