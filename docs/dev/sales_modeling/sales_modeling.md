---
markdown:
  image_dir: ./assets
  ignore_from_front_matter: true
  absolute_image_path: false
---

SalesModeling
---
## 商品モデルの設計
### シンプルな商品モデル
#### 分析モデル
```puml
class 商品 {
  - 商品名
  - 仕入単価
  - 販売単価
}
class サイズ {
  - サイズ名
}
class カラー {
  - カラー名
}
class 商品区分 {
  - 商品区分名
}
商品 --ro サイズ
商品 -o カラー
商品 --o 商品区分
```
#### 設計モデル
```puml
class Product {
  - code
  - name
  - size
  - color
  - product_category
  - unit_purchase_price
  - unit_sales_price
}
class Size {
  - code
  - name
}
class Color {
  - code
  - name
}
class ProductCategory {
  - code
  - name
}
Product --ro Size
Product -o Color
Product --o ProductCategory
```
#### ERモデル
```puml
entity Product {
  + code [PK]
  --
  name
  # size_code [FK]
  # color_code [FK]
  # product_category_code [FK]
  unit_purchase_price
  unit_sales_price
}
entity Size {
  + code [PK]
  --
  name
}
entity Color {
  + code [PK]
  --
  name
}
entity ProductCategory {
  + code [PK]
  --
  name
}
Product }-do-||  Size
Product }-do-|| Color
Product }-do-|| ProductCategory
```
`Product`
@import "../../../app/models/sales_modeling/product.rb"
`Size`
@import "../../../app/models/sales_modeling/size.rb"
`Color`
@import "../../../app/models/sales_modeling/color.rb"
`ProductCategory`
@import "../../../app/models/sales_modeling/product_category.rb"
