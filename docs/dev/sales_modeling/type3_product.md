---
markdown:
  image_dir: ./assets
  ignore_from_front_matter: true
  absolute_image_path: false
---

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
```puml
class 商品 {
  品番
  品名
}
class SKU {
  仕入単価
  販売単価
}
class 商品区分 {
}
class シーズン {
}
class 年度 {
}
class ブランド {
}
class サイズ {  
}
class 色 {  
}
商品 *-- SKU
商品 -o ブランド
ブランド -o ブランド
商品 -ro 商品区分
商品区分 -o 商品区分
シーズン o-- 商品
シーズン -o 年度
SKU -o サイズ
SKU -ro 色

```
## 設計モデル
```puml
class Product {
  code
  name
}
class SKU {
  code
}
class Year {
  code
  name
  valid?()  
}
class Season {
  code
  name
  valid?()  
}
class Brand {
  code
  name
  valid?()  
}
class ProductType {
  code
  name
  valid?()  
}
class Size {
  code
  name
  valid?()  
}
class Color {
  code
  name
  valid?()  
}
class ProductCode {
  code
  valid?()
}
class SkuCode {
  code
  valid?()
}
class UnitPurchasePrice {
}
class UnitSalesPrice {
}
abstract Money {
  amount
  currency
}
abstract Code {  
}
abstract Type {  
}
abstract Price {  
}

Product *-- SKU
Product -o Brand
Brand -o Brand
Product -o ProductType
ProductType -o ProductType
Season o-- Product
Season -o Year
SKU -o Size
SKU -ro Color
Product o--l ProductCode
SKU o-- UnitPurchasePrice
SKU o-- UnitSalesPrice
SKU o-- SkuCode
Code <|... Season
Code <|... Year
Type <|.. ProductType
Code <|... Brand
Code <|... ProductCode
Code <|.... Color
Code <|... Size
Code <|... SkuCode
Money <|... Price
Price <|.... UnitPurchasePrice
Price <|.... UnitSalesPrice
```
## ERモデル
```puml
entity Product {
  + code [PK]
  --
  name
  # product_type_category_code [FK]
  # brand_category_code [FK]    
  # season_category_code [FK]
  # year_category_code [FK]  
}
entity SKU {
  + code [PK]
  --
  unit_purchase_price_amount
  unit_purchase_price_currency
  unit_sales_price_amount
  unit_sales_price_currency        
  # product_code [FK]    
  # size_category_code [FK]
  # color_category_code [FK]  
}
entity Category {
  + code [PK]  
  # category_class_code [FK]    
  --
  name
  # parent_code [FK]    
}
entity CategoryClass {
  + code [PK]
  --
  name
}
Product }-do-|| Category
SKU }-do-|| Category
SKU }-do-|| Product
Category }-do-|| Category
Category }-do-|| CategoryClass
```
`SKU`
@import "../../../app/models/sales_modeling/type3/sku.rb"
`Product`
@import "../../../app/models/sales_modeling/type3/product.rb"
`Category`
@import "../../../app/models/sales_modeling/type3/category.rb"
`CategoryClass`
@import "../../../app/models/sales_modeling/type3/category_class.rb"
`ProductCode`
@import "../../../app/models/sales_modeling/type3/value_object/product_code.rb"
`Year`
@import "../../../app/models/sales_modeling/type3/value_object/year.rb"
`Season`
@import "../../../app/models/sales_modeling/type3/value_object/season.rb"
`ProductType`
@import "../../../app/models/sales_modeling/type3/value_object/product_type.rb"
`Brand`
@import "../../../app/models/sales_modeling/type3/value_object/brand.rb"
`SkuCode`
@import "../../../app/models/sales_modeling/type3/value_object/sku_code.rb"
`Color`
@import "../../../app/models/sales_modeling/type3/value_object/color.rb"
`Size`
@import "../../../app/models/sales_modeling/type3/value_object/size.rb"
`UnitPurchasePrice`
@import "../../../app/models/sales_modeling/type3/value_object/unit_purchase_price.rb"
`UnitSalesPrice`
@import "../../../app/models/sales_modeling/type3/value_object/unit_sales_price.rb"
`Type`
@import "../../../app/models/concerns/sales_modeling/type.rb"
`Code`
@import "../../../app/models/concerns/sales_modeling/code.rb"
`Price`
@import "../../../app/models/concerns/sales_modeling/price.rb"
`Money`
@import "../../../app/models/concerns/sales_modeling/money.rb"