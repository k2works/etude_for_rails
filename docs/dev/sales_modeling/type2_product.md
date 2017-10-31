---
markdown:
  image_dir: ./assets
  ignore_from_front_matter: true
  absolute_image_path: false
---

SalesModeling
---
# 分類を汎化した商品モデル
## 分析モデル
```puml
class 商品 {
  - 品番
  - 品名
  - 仕入単価
  - 販売単価  
}
class 分類 {
  - 分類名
}
class 分類種別 {
  - 分類種別名
}
商品 --lo 分類
分類 -o 分類
分類 --o 分類種別
```
## 設計モデル
```puml
class Product {
  product_code
  name
  size
  color
  product_category
  unit_purchase_price
  unit_sales_price
}
class Size {
  code
  name
}
class Color {
  code
  name
}
class ProductCategory {
  code
  name
}
class ProductCode {
  code
  valid?()
}
class Money {
  amount
  currency
}
Product --ro Size
Product -o Color
Product --o ProductCategory
Product o-- ProductCode
Product o-- Money
```
## ERモデル
```puml
entity Product {
  + code [PK]
  --
  name
  # size_code [FK]
  # color_code [FK]
  # product_category_code [FK]
  unit_purchase_price_amount
  unit_purchase_price_currency
  unit_sales_price_amount
  unit_sales_price_currency  
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
Category }-do-|| Category
Category }-do-|| CategoryClass
```
`Product`
@import "../../../app/models/sales_modeling/type2/product.rb"
`Category`
@import "../../../app/models/sales_modeling/type2/category.rb"
`CategoryClass`
@import "../../../app/models/sales_modeling/type2/category_class.rb"
`ProductCode`
@import "../../../app/models/sales_modeling/type2/product_code.rb"
`Money`
@import "../../../app/models/sales_modeling/type2/money.rb"
